//
//  ContentView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 24.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Tab = .exercise
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab ) {
                ExerciseView()
                    .tag(Tab.exercise)
                AchievementsView(viewModel: AchievementsViewModel())
                    .tag(Tab.achievements)
                GoalsView(viewModel: GoalsViewModel())
                    .tag(Tab.goals)
                NutrionPlansView()
                    .tag(Tab.nutrionPlan)
                ProfileView()
                    .tag(Tab.profile)
                   
            }
            CustomTabBar(selectedTab: $selectedTab)
        }
        .navigationBarBackButtonHidden(true)
    }
        
}

#Preview {
    ContentView()
}
