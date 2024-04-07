//
//  Meals.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation

struct PlanMeals: Identifiable {
    var id = UUID()
    var name: String
    var kkal: String
    var imageName: String
    var meals: [Meals]
}

struct Meals: Identifiable {
    var id = UUID()
    var name: String
    var kkal: String
    var proteins: String
    var fats: String
    var carbs: String
}

