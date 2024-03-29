//
//  SelectedPlanMealView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import SwiftUI

struct SelectedPlanMealView: View {
    var meals: Meals
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SelectedPlanMealView(meals: Meals(name: "Pump Up", kkal: "2300", imageName: "pumpUP"))
}
