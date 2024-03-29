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
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab, content: {
                PlanMealsView(viewModel: PlanMealsViewModel()).tag(0)
                MealsView().tag(1)
            })
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)
            NavigationBarView(currentTab: $currentTab, namespace: _namespace, navigationitems: navigationItems, spacing: 135)
        }
    }
}

#Preview {
    NutrionPlansView()
}
