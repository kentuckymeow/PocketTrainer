//
//  ContentView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Tab = .exercise
    @State var isProfilePopUpViewShown: Bool = true
    @ObservedObject var viewModel: HealthDataViewModel
    
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
                ProfileView(viewModel: HealthDataViewModel())
                    .tag(Tab.profile)
                   
            }
            CustomTabBar(selectedTab: $selectedTab)
            
           
        }
        
        .sheet(isPresented: $isProfilePopUpViewShown) {
            ProfilePopUpView(viewModel: viewModel, isProfilePopUpViewShown: $isProfilePopUpViewShown)
        }
        .navigationBarBackButtonHidden(true)
    }
        
}

#Preview {
    ContentView(viewModel: HealthDataViewModel())
}
