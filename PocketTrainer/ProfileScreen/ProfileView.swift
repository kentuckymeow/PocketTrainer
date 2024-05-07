//
//  ProfileView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: HealthDataViewModel

    var body: some View {
        VStack {
            Text("Profile information")
                .font(.headline)
            TextField("Name", text: $viewModel.name)
            TextField("Email", text: $viewModel.email)
            
            Text("Health data")
                .font(.headline)
            Picker("Gender", selection: $viewModel.gender) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    Text(gender.rawValue).tag(gender)
                }
            }
            TextField("Weight", value: $viewModel.weight, formatter: NumberFormatter())
            TextField("Height", value: $viewModel.height, formatter: NumberFormatter())
            DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
            Picker("Primary Goal", selection: $viewModel.primaryGoal) {
                ForEach(PrimaryGoal.allCases, id: \.self) { goal in
                    Text(goal.rawValue).tag(goal)
                }
            }
            Picker("Fitness Level", selection: $viewModel.fitnessLevel) {
                ForEach(FitnessLevel.allCases, id: \.self) { level in
                    Text(level.rawValue).tag(level)
                }
            }
            
            Button(action: updateHealthData) {
                Text("Update Health Data")
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .onAppear(perform: loadHealthData)
    }
    
        

    
    func loadHealthData() {
        // Попытка загрузить данные из UserDefaults
        var savedHealthData: HealthDataModel?
        if let savedData = UserDefaults.standard.data(forKey: "HealthData") {
            do {
                savedHealthData = try JSONDecoder().decode(HealthDataModel.self, from: savedData)
                self.viewModel.update(with: savedHealthData!)
            } catch {
                print("Failed to load health data from UserDefaults: \(error.localizedDescription)")
            }
        }

        // Выполните запрос к серверу
        let userRequest = HealthDataModel(
            gender: viewModel.gender,
            weight: viewModel.weight,
            height: viewModel.height,
            dateOfBirth: viewModel.dateOfBirth,
            primaryGoal: viewModel.primaryGoal,
            fitnessLevel: viewModel.fitnessLevel
        )
        // Создайте запрос для метода userHealthData
        guard let request = Endpoint.userHealthData(userRequest: userRequest).request else { return }

        // Выполните запрос с помощью AuthService.fetch()
        AuthService.fetch(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let rawString = String(data: data, encoding: .utf8)
                    print("Raw data: \(rawString ?? "No data")")
                    do {
                        // Декодирование данных
                        let formatter = ISO8601DateFormatter()
                        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .custom { decoder in
                            let container = try decoder.singleValueContainer()
                            let dateString = try container.decode(String.self)
                            if let date = formatter.date(from: dateString) {
                                return date
                            } else {
                                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
                            }
                        }

                        let healthData = try decoder.decode(HealthDataModel.self, from: data)
                        
                        // Проверьте, совпадают ли новые данные с сохраненными данными
                        if healthData != savedHealthData {
                            // Если данные не совпадают, обновите viewModel и сохраните новые данные в UserDefaults
                            self.viewModel.update(with: healthData)

                            do {
                                let data = try JSONEncoder().encode(healthData)
                                UserDefaults.standard.set(data, forKey: "HealthData")
                            } catch {
                                print("Failed to save health data to UserDefaults: \(error.localizedDescription)")
                            }
                        }
                        
                    } catch {
                        print("Failed to decode health data: \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("Failed to get user health data: \(error.localizedDescription)")
                }
            }
        }
    }

    
        
    func updateHealthData() {
        let userRequest = HealthDataModel(
            gender: viewModel.gender,
            weight: viewModel.weight,
            height: viewModel.height,
            dateOfBirth: viewModel.dateOfBirth,
            primaryGoal: viewModel.primaryGoal,
            fitnessLevel: viewModel.fitnessLevel
        )
        
        guard let request = Endpoint.healthDataUpdate(userRequest: userRequest).request else { return }
        
        AuthService.fetch(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    // Handle success, update UI, etc.
                    print("Health data updated successfully.")
                    
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                        // Show an alert with the error message
                        print("Failed to update health data: \(string)")
                    }
                }
            }
        }
    }

}

#Preview {
    ProfileView(viewModel: HealthDataViewModel())
}
