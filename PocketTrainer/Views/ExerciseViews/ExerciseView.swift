//
//  ExerciseView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 27.03.2024.
//

import SwiftUI

struct ExerciseView: View {
    @State var currentTab: Int = 0
    @Namespace var namespace
    var navigationItems: [String] = ["Workout selection", "Favourite workouts"]

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab, content: {
                WorkoutSelectionView(viewModel: TrainingViewModel()).tag(0)
                FavouriteWorkoutsView().tag(1)
            })
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)
            NavigationBarView(currentTab: $currentTab, namespace: _namespace, navigationitems: navigationItems, spacing: 30)
        }
    }
}


#Preview {
    ExerciseView()
}
