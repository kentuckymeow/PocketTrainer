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
    
    var localized: String {
        switch self {
        case .male: return "Мужчина"
        case .female: return "Женщина"
        }
    }
}

enum PrimaryGoal: String, Codable, CaseIterable {
    case buildMuscle = "BuildMuscule"
    case eatBetter = "EatBetter"
    case increaseEndurance = "Increase_Endurance"
    case improveFitness = "Improve_Fitness"
    case burnFat = "Burn_Fat"
    case relieveStress = "Relieve_Stress"
    
    var localized: String {
        switch self {
        case .buildMuscle: return "Нарастить мышцы"
        case .eatBetter: return "Питаться лучше"
        case .increaseEndurance: return "Увеличить выносливость"
        case .improveFitness: return "Улучшить фитнес"
        case .burnFat: return "Сжечь жир"
        case .relieveStress: return "Снять стресс"
        }
    }
}

enum FitnessLevel: String, Codable, CaseIterable {
    case beginner = "Beginner"
    case low = "Low"
    case medium = "Medium"
    case advanced = "Advanced"
    
    var localized: String {
        switch self {
        case .beginner: return "Начинающий"
        case .low: return "Низкий"
        case .medium: return "Средний"
        case .advanced: return "Продвинутый"
        }
    }
}


struct HealthDataModel: Codable, Equatable {
    let gender: Gender
    let weight: Int
    let height: Int
    let dateOfBirth: Date
    let primaryGoal: PrimaryGoal
    let fitnessLevel: FitnessLevel
}

