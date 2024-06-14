//
//  File.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation

struct Training: Identifiable, Codable{
    var id: Int
    var name: String
    var duration: Int
    var imageUrl: String
    var description: String
    var videoUrl: String
    var WorkoutToExercise: [WorkoutToExercise]
}

struct WorkoutToExercise: Identifiable, Codable {
    var id: Int
    var workoutId: Int
    var exerciseId: Int
    var exercise: Exercise
}

struct Exercise: Identifiable, Codable {
    var id: Int
    var name: String
    var sets: String
    var image: String
    var video: String
    var description: String
}
