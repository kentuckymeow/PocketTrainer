//
//  WorkoutView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import SwiftUI

struct WorkoutView: View {
    let training: Training

    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(training.WorkoutToExercise) { workoutToExercise in
                        NavigationLink(destination: SelectedExersiseView(exercise:  workoutToExercise.exercise)) {
                            ZStack(alignment: .bottomLeading) {
                                Image(workoutToExercise.exercise.image)
                                    .frame(height: 120)
                                    .cornerRadius(25)
                                VStack(alignment:.leading) {
                                    Text(workoutToExercise.exercise.name)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text("\(workoutToExercise.exercise.sets)")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 0))
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
//    WorkoutView(training: Training(name: "Base Crossfit", duration: "30 min", imageName: "crossfit", description: "Фу", videoUrl: "sam2", exercises: [
//        Exercise(name: "Bench press", sets: "4x10", imageName: "BenchPress",videoUrl: "Bench press", description:""),
//        Exercise(name: "Seated dumbbell press", sets: "4x10", imageName: "DumbbellPress",videoUrl: "", description:""),
//    ]))
//}
