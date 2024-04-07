//
//  ProfileView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var healthData: HealthData

    var body: some View {
        Form {
            Section(header: Text("Profile information")) {
                TextField("Name", text: $healthData.name)
                TextField("Email", text: $healthData.email)
            }
            
            Section(header: Text("Health data")) {
                TextField("Weight", value: $healthData.weight, formatter: NumberFormatter())
                TextField("Height", value: $healthData.height, formatter: NumberFormatter())
                TextField("Age", value: $healthData.age, formatter: NumberFormatter())
            }
        }
    }
}

#Preview {
    ProfileView(healthData: HealthData())
}
