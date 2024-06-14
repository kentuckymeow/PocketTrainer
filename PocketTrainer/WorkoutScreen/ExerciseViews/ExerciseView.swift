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
    var navigationItems: [String] = ["Выбор тренировки", "Любимые тренировки"]
    @StateObject var viewModel = TrainingViewModel()

    var body: some View {
        NavigationView {
            ZStack {
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
                        WorkoutSelectionView(viewModel: viewModel)
                    default:
                        FavouriteWorkoutsView(viewModel: viewModel)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                }
            }
        }
    }
}



//#Preview {
//    ExerciseView()
//}
