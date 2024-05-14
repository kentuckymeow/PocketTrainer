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
            TextField("Weight", value: $viewModel.weight, formatter: NumberFormatter())
                    .textFieldStyle(CustomTextFieldStyle())
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
                    
            Button(action: saveHealthData) {
                Text("Save Health Data")
                    .frame(width: 200,height: 60)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        }
        .padding()
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
