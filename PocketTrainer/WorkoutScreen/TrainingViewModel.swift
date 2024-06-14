//
//  TrainingViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation
import SwiftUI

class TrainingViewModel: ObservableObject {
    @Published var trainings: [Training] = []
    @Published var favouriteWorkouts: [Training] = []
    @Published var isLoading: Bool = true
    
    init() {
        fetchTrainings()
    }
    
    func fetchTrainings() {
        if let savedTrainings = DataManager.shared.loadTrainingsLocally() {
            self.trainings = savedTrainings
            self.isLoading = false
        } else {
            let exercise = Exercise(id: 1, name: "Example Exercise", sets: "4x10", image: "exampleImage", video: "exampleVideoUrl", description: "Example Description")
            let workoutToExercise = WorkoutToExercise(id: 1, workoutId: 1, exerciseId: 1, exercise: exercise)
            let userRequest = Training(id: 1, name: "Example Training", duration: 30, imageUrl: "exampleImage", description: "Example Description", videoUrl: "exampleVideoUrl", WorkoutToExercise: [workoutToExercise])

            guard let request = Endpoint.findAllWorkouts(userRequest: userRequest).request else { return }
            
            AuthService.fetch(request: request) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        print("Data received from server: \(data)")
                        do {
                            self.trainings = try JSONDecoder().decode([Training].self, from: data)
                            self.isLoading = false
                            DataManager.shared.saveTrainingsLocally(trainings: self.trainings)
                            
                            self.downloadMediaForTrainings()
                        } catch {
                            print("Failed to decode training data: \(error)")
                        }
                    case .failure(let error):
                        guard let error = error as? ServiceError else { return }
                        switch error {
                        case .serverError(let string),
                                .unknown(let string),
                                .decodingError(let string):
                            print("Failed to fetch training data: \(string)")
                        }
                    }
                }
            }
        }
    }
    
    private func downloadMediaForTrainings() {
        for training in self.trainings {
            if let imageUrl = URL(string: training.imageUrl) {
                DataManager.shared.downloadImage(from: imageUrl) { image in
                    if let image = image {
                        DataManager.shared.saveImageLocally(image: image, imageName: "\(training.id)_image.jpg")
                    }
                }
            }
            
            if let videoUrl = URL(string: training.videoUrl) {
                DataManager.shared.downloadVideo(from: videoUrl) { videoData in
                    if let videoData = videoData {
                        DataManager.shared.saveVideoLocally(videoData: videoData, videoName: "\(training.id)_video.mp4")
                    }
                }
            }
            
            for workoutToExercise in training.WorkoutToExercise {
                let exercise = workoutToExercise.exercise
                if let exerciseImageUrl = URL(string: exercise.image) {
                    DataManager.shared.downloadImage(from: exerciseImageUrl) { image in
                        if let image = image {
                            DataManager.shared.saveImageLocally(image: image, imageName: "\(exercise.id)_image.jpg")
                        }
                    }
                }
                
                if let exerciseVideoUrl = URL(string: exercise.video) {
                    DataManager.shared.downloadVideo(from: exerciseVideoUrl) { videoData in
                        if let videoData = videoData {
                            DataManager.shared.saveVideoLocally(videoData: videoData, videoName: "\(exercise.id)_video.mp4")
                        }
                    }
                }
            }
        }
    }

    func addFavouriteWorkout(_ workout: Training) {
        if !favouriteWorkouts.contains(where: { $0.id == workout.id }) {
            favouriteWorkouts.append(workout)
        }
    }

    func removeFavouriteWorkout(_ workout: Training) {
        if let index = favouriteWorkouts.firstIndex(where: { $0.id == workout.id }) {
            favouriteWorkouts.remove(at: index)
        }
    }
}
