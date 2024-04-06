//
//  PlanMealsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation

class PlanMealsViewModel: ObservableObject {
    @Published var meals = [
        Meals(name: "Pump Up", kkal: "2300", imageName: "pumpUp"),
        Meals(name: "Body balance", kkal: "1700", imageName: "bodyBalance"),
    ]
}
