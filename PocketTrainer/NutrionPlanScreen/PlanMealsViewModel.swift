//
//  PlanMealsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation

class PlanMealsViewModel: ObservableObject {
    @Published var planMeals = [
        PlanMeals(name: "Pump Up", kkal: "2300", imageName: "pumpUp", meals: [
            Meals(name: "Orange oatmeal with fruit", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20"),
            Meals(name: "Hot dog with chicken boiled pork", kkal: "735", proteins: "51.20", fats: "26.50", carbs: "72.80")]),
        PlanMeals(name: "Body balance", kkal: "1700", imageName: "bodyBalance", meals: [
            Meals(name: "Orange oatmeal with fruit", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20"),
            Meals(name: "Hot dog with chicken boiled pork", kkal: "735", proteins: "51.20", fats: "26.50", carbs: "72.80")]),
                   
    ]
}
