//
//  TrainingViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation

class TrainingViewModel: ObservableObject {
//    @Published var trainings: [Training] = [
//        Training(name: "Base Crossfit", duration: "30 min", imageName: "crossfit", description: "Не наберешь мышц, но познакомишься с парнем", videoUrl: "sam", exercises: [
//            Exercise(name: "Bench press", sets: "4x10", imageName: "BenchPress",videoUrl:"video", description:
//                     """
//                     "How to do a bench press
//                     Equipment needed: barbell (additional weights optional) or dumbbells, flat bench
//                     Lie on your back on a flat bench. Grip a barbell with hands slightly wider than shoulder width. The bar should be directly over the shoulders.
//                     Press your feet firmly into the ground and keep your hips on the bench throughout the entire movement.
//                     Keep your core engaged and maintain a neutral spine position throughout the movement. Avoid arching your back.
//                     Slowly lift the bar or dumbbells off the rack, if using. Lower the bar to the chest, about nipple level, allowing elbows to bend out to the side, about 45 degrees away from the body.
//                     Stop lowering when your elbows are just below the bench. Press feet into the floor as you push the bar back up to return to starting position.
//                     Perform 5 to 10 reps, depending on weight used. Perform up to 3 sets.
//                    """),
//            Exercise(name: "Seated dumbbell press", sets: "4x10", imageName: "DumbbellPress", videoUrl: "", description: ""),
//        ]),
//        Training(name: "Bodybuilding", duration: "1h ", imageName: "bodybuilding", description: "МЫШЦЫ КАЧАТЬ КУШАТЬ СПАТЬ", videoUrl: "sam", exercises: [
//            Exercise(name: "Lunges with dumbbells", sets: "4x10", imageName: "Lunges",videoUrl: "", description: ""),
//            Exercise(name: "Dumbbell row", sets: "4x10", imageName: "DumbbellRow",videoUrl: "", description: ""),
//        ]),
//    ]
//    
    @Published var trainings: [Training] = []
    
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
