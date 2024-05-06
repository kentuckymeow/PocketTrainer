//
//  ContentView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Tab = .exercise
    @State var isProfilePopUpViewShown: Bool = false
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
                .interactiveDismissDisabled(true)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            checkHealthData()
        }
    }
    func checkHealthData() {
        let userRequest = HealthDataModel(
            gender: viewModel.gender,
            weight: viewModel.weight,
            height: viewModel.height,
            dateOfBirth: viewModel.dateOfBirth,
            primaryGoal: viewModel.primaryGoal,
            fitnessLevel: viewModel.fitnessLevel
        )
        
        guard let request = Endpoint.userHealthData(userRequest: userRequest).request else { return }

        AuthService.fetch(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if data.isEmpty {
                        self.isProfilePopUpViewShown = true
                    } else {
                        self.isProfilePopUpViewShown = false
                    }
                    
                case .failure(let error):
                    print("Failed to get user health data: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: HealthDataViewModel())
}
