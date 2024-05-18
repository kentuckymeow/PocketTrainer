//
//  WorkoutSelectionView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct WorkoutSelectionView: View {
    @ObservedObject var viewModel: TrainingViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.trainings) { training in
                    NavigationLink(destination: WorkoutDetailView(training: training)) {
                        ZStack(alignment: .bottomLeading) {
                            AsyncImage(url: URL(string: training.imageUrl)) { image in
                                image
                                    .frame(height: 120)
                                    .cornerRadius(25)
                            } placeholder: {
                                Color.gray
                            }
                            VStack(alignment:.leading) {
                                Text(training.name)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("Duration: \(training.duration)")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 0))
                            
                            Button(action: {
                                if viewModel.favouriteWorkouts.contains(where: { $0.id == training.id }) {
                                    viewModel.removeFavouriteWorkout(training)
                                } else {
                                    viewModel.addFavouriteWorkout(training)
                                }
                            }) {
                                Image(systemName: viewModel.favouriteWorkouts.contains(where: { $0.id == training.id }) ? "heart.fill" : "heart")
                                    .foregroundColor(.white)
                                    .padding(.init(top: 0, leading: 320, bottom: 15, trailing: 0))
                            }
                        }
                        .padding(.vertical)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}


//#Preview {
//    WorkoutSelectionView(viewModel: TrainingViewModel(), isTabViewShown: isTabViewShown)
//}
