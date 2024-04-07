//
//  SelectedPlanMealView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import SwiftUI

struct SelectedPlanMealView: View {
    var planMeals: PlanMeals
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SelectedPlanMealView(planMeals: PlanMeals(name: "Pump Up", kkal: "2300", imageName: "pumpUp", meals: [Meals(name: "Orange oatmeal with fruit", kkal: "501", proteins: "9.90", fats: "19.20", carbs: "72.20"),]))
}
