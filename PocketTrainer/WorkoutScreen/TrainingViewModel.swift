//
//  TrainingViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import Foundation

class TrainingViewModel: ObservableObject {
    @Published var trainings = [
        Training(name: "Base Crossfit", time: "30 min", imageName: "crossfit"),
        Training(name: "Bodybuilding", time: "1h ", imageName: "bodybuilding"),
        Training(name: "Bodybuilding", time: "1h ", imageName: "bodybuilding"),
        
    ]
}
