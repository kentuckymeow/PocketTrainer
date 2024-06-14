//
//  HealthsData.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.04.2024.
//

import Foundation

enum Gender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
}

enum PrimaryGoal: String, Codable, CaseIterable {
    case buildMuscle = "BuildMuscule"
    case eatBetter = "EatBetter"
    case increaseEndurance = "Increase_Endurance"
    case improveFitness = "Improve_Fitness"
    case burnFat = "Burn_Fat"
    case relieveStress = "Relieve_Stress"
}

enum FitnessLevel: String, Codable, CaseIterable {
    case beginner = "Beginner"
    case low = "Low"
    case medium = "Medium"
    case advanced = "Advanced"
}

struct HealthDataModel: Codable, Equatable {
    let gender: Gender
    let weight: Int
    let height: Int
    let dateOfBirth: Date
    let primaryGoal: PrimaryGoal
    let fitnessLevel: FitnessLevel
}

