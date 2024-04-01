//
//  NutrionPlans.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct NutrionPlansView: View {
    @State var currentTab: Int = 0
    @Namespace var namespace
    var navigationItems: [String] = ["Plan meals", "Meals"]

    var body: some View {
        NavigationView {
            VStack {
                Picker("Tabs", selection: $currentTab) {
                    ForEach(navigationItems.indices, id: \.self) { index in
                        Text(self.navigationItems[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                switch currentTab {
                case 0:
                    PlanMealsView(viewModel: PlanMealsViewModel())
                default:
                    MealsView()
                }
            }
        }
    }
}

#Preview {
    NutrionPlansView()
}
