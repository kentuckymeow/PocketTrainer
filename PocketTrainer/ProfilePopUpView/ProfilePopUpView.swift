//
//  ProfilePopUpView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 04.05.2024.
//

import SwiftUI

struct ProfilePopUpView: View {
    @ObservedObject var viewModel: HealthDataViewModel
    @Binding var isProfilePopUpViewShown: Bool

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
                
                VStack(alignment: .leading, spacing: 10) {
                    DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .accentColor(.black)
                        .font(.headline)
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
                    .accentColor(.secondary)
                    .pickerStyle(MenuPickerStyle())
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
                    .accentColor(.secondary)
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal)
                
                Button(action: saveHealthData) {
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
    }
        
    func saveHealthData() {
        let userRequest = HealthDataModel(
            gender: viewModel.gender,
            weight: viewModel.weight,
            height: viewModel.height,
            dateOfBirth: viewModel.dateOfBirth,
            primaryGoal: viewModel.primaryGoal,
            fitnessLevel: viewModel.fitnessLevel
        )
        
        guard let request = Endpoint.healthData(userRequest: userRequest).request else { return }
        
        AuthService.fetch(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Health data saved successfully.")
                    self.isProfilePopUpViewShown = false
                    
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                        print("Failed to save health data: \(string)")
                        self.isProfilePopUpViewShown = false
                    }
                }
            }
        }
    }
}


#Preview {
    ProfilePopUpView(viewModel: HealthDataViewModel(), isProfilePopUpViewShown: .constant(false))
}
