//
//  Favourite workouts.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct FavouriteWorkoutsView: View {
    @ObservedObject var viewModel: TrainingViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.favouriteWorkouts) { workout in
                    NavigationLink(destination: WorkoutDetailView(training: workout)) {
                    ZStack(alignment: .bottomLeading) {
                        AsyncImage(url: URL(string: workout.imageUrl)) { image in
                            image
                                .frame(height: 120)
                                .cornerRadius(25)
                        } placeholder: {
                            Color.gray
                                .frame(height: 120)
                                .cornerRadius(25)
                        }
                        VStack(alignment:.leading) {
                            Text(workout.name)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Duration: \(workout.duration)")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 0))
                    }
                    .padding(.vertical)
                }
                }
            }
            .padding()
        }
    }
}


//#Preview {
//    FavouriteWorkoutsView(viewModel: TrainingViewModel(), showTabBar: Binding<Bool>)
//}
