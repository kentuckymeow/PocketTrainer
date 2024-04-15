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
    
    // Создаем один экземпляр TrainingViewModel
    @StateObject var viewModel = TrainingViewModel()

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
                    // Передаем viewModel в WorkoutSelectionView
                    WorkoutSelectionView(viewModel: viewModel)
                default:
                    // Передаем viewModel в FavouriteWorkoutsView
                    FavouriteWorkoutsView(viewModel: viewModel)
                }
            }
        }
    }
}



#Preview {
    ExerciseView()
}
