//
//  TrainingViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation

class TrainingViewModel: ObservableObject {
    @Published var trainings: [Training] = []
    @Published var isLoading: Bool = true
    
    init() {
        fetchTrainings()
    }
    
    func fetchTrainings() {
        let exercise = Exercise(id: 1, name: "Example Exercise", sets: "4x10", image: "exampleImage", video: "exampleVideoUrl", description: "Example Description")
        let workoutToExercise = WorkoutToExercise(id: 1, workoutId: 1, exerciseId: 1, exercise: exercise)
        let userRequest = Training(id: 1, name: "Example Training", duration: 30, imageUrl: "exampleImage", description: "Example Description", videoUrl: "exampleVideoUrl", WorkoutToExercise: [workoutToExercise])


        guard let request = Endpoint.findAllWorkouts(userRequest: userRequest).request else {return}
            
            AuthService.fetch(request: request) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        print("Data received from server: \(data)")
                        do {
                            self.trainings = try JSONDecoder().decode([Training].self, from: data)
                            self.isLoading = false
                        } catch {
                            print("Failed to decode training data: \(error)")
                        }
                        
                    case .failure(let error):
                        guard let error = error as? ServiceError else { return }
                        
                        switch error {
                        case .serverError(let string),
                                .unkown(let string),
                                .decodingError(let string):
                            print("Failed to fetch training data: \(string)")
                        }
                    }
                }
            }
        }
    
    
    @Published var favouriteWorkouts: [Training] = [] // Добавляем список избранных тренировок

       // Метод для добавления тренировки в список избранных
       func addFavouriteWorkout(_ workout: Training) {
           if !favouriteWorkouts.contains(where: { $0.id == workout.id }) {
               favouriteWorkouts.append(workout)
           }
       }

       // Метод для удаления тренировки из списка избранных
       func removeFavouriteWorkout(_ workout: Training) {
           if let index = favouriteWorkouts.firstIndex(where: { $0.id == workout.id }) {
               favouriteWorkouts.remove(at: index)
           }
       }
}
