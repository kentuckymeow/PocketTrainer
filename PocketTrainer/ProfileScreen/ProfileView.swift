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
        VStack() {
            Text("Health data")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Сhoose your gender")
                .font(.headline)
            Picker("Gender", selection: $viewModel.gender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
            }
            .pickerStyle(.inline)
            Text("Write your weight in kg")
                .font(.headline)
            TextField("Weight", value: $viewModel.weight, formatter: NumberFormatter())
                    .textFieldStyle(CustomTextFieldStyle())
            Text("Write your height in сm")
                .font(.headline)
            TextField("Height", value: $viewModel.height, formatter: NumberFormatter())
                    .textFieldStyle(CustomTextFieldStyle())
            DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
            Text("Primary Goal")
                .font(.headline)
            Picker("Primary Goal", selection: $viewModel.primaryGoal) {
                ForEach(PrimaryGoal.allCases, id: \.self) { goal in
                            Text(goal.rawValue).tag(goal)
                }
            }
                .pickerStyle(.inline)
            Text("Fitness Level")
                .font(.headline)
            Picker("Fitness Level", selection: $viewModel.fitnessLevel) {
                ForEach(FitnessLevel.allCases, id: \.self) { level in
                            Text(level.rawValue).tag(level)
                }
            }
                .pickerStyle(.inline)
                    
            Button(action: updateHealthData) {
                Text("Update Health Data")
                    .frame(width: 200,height: 60)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        }
        .padding()
        .onAppear(perform: loadHealthData)
    }

    
    func loadHealthData() {
        var savedHealthData: HealthDataModel?
        if let savedData = UserDefaults.standard.data(forKey: "HealthData") {
            do {
                savedHealthData = try JSONDecoder().decode(HealthDataModel.self, from: savedData)
                self.viewModel.update(with: savedHealthData!)
            } catch {
                print("Failed to load health data from UserDefaults: \(error.localizedDescription)")
            }
        }

        let userRequest = HealthDataModel(
            gender: viewModel.gender,
            weight: viewModel.weight,
            height: viewModel.height,
            dateOfBirth: viewModel.dateOfBirth,
            primaryGoal: viewModel.primaryGoal,
            fitnessLevel: viewModel.fitnessLevel
        )
        
        guard let request = Endpoint.userHealthData(userRequest: userRequest).request else { return }

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
                    
                        if healthData != savedHealthData {
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
                    print("Health data updated successfully.")
                    
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
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
