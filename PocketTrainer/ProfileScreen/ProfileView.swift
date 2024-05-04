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
