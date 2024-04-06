//
//  GoalsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 31.03.2024.
//

import Foundation

class GoalsViewModel: ObservableObject {
    @Published var goals: [Goal] = []
    
    func addGoal(name: String, weight: String, reps: String, sets: String, date: Date) {
        let newGoal = Goal(name: name, weight: weight, reps: reps, sets: sets, date: date)
        goals.append(newGoal)
    }
    
    func updateGoal(id: UUID, name: String, weight: String, reps: String, sets: String, date: Date) {
        if let index = goals.firstIndex(where: { $0.id == id }) {
            goals[index].name = name
            goals[index].weight = weight
            goals[index].reps = reps
            goals[index].sets = sets
            goals[index].date = date
        }
    }
    
    
}
