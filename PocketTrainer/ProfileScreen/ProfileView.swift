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
            ScrollView {
                VStack(spacing: 20) {
                    Text("Health Data")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Choose your gender")
                            .font(.headline)
                            .foregroundColor(.black)

                        Picker("Gender", selection: $viewModel.gender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue).tag(gender)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Write your weight in kg")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        TextField("Weight", value: $viewModel.weight, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Write your height in cm")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        TextField("Height", value: $viewModel.height, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .center) {
                        DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                            .font(.headline)
                            .datePickerStyle(.compact)
                            .accentColor(.black)
                    }
                    .padding(.horizontal)

                    VStack(alignment: .center) {
                        Text("Primary Goal")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Picker("Primary Goal", selection: $viewModel.primaryGoal) {
                            ForEach(PrimaryGoal.allCases, id: \.self) { goal in
                                Text(goal.rawValue).tag(goal)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Fitness Level")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Picker("Fitness Level", selection: $viewModel.fitnessLevel) {
                            ForEach(FitnessLevel.allCases, id: \.self) { level in
                                Text(level.rawValue).tag(level)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    Button(action: updateHealthData) {
                        Text("Update Health Data")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .padding()
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
            .onAppear(perform: loadHealthData)
            .toolbar(.hidden,for: .tabBar)
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
