//
//  HealthData.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 07.04.2024.
//

import Foundation

class HealthDataViewModel: ObservableObject {
    @Published var name: String = "Arseni"
    @Published var email: String = "khatsuk2003@mail.ru"
    @Published var gender: Gender = .male
    @Published var weight: Int = 0
    @Published var height: Int = 0
    @Published var dateOfBirth: Date = Date()
    @Published var primaryGoal: PrimaryGoal = .buildMuscle
    @Published var fitnessLevel: FitnessLevel = .beginner
}
