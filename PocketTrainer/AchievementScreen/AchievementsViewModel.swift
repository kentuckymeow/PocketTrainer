//
//  AchievementsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 30.03.2024.
//

import Foundation

class AchievementsViewModel:ObservableObject {
    @Published var achievements = [
        Achievement(name: "First training", imageName: "trophyOn", dateOfCollect: DateComponents(calendar: .current,year: 2024, month: 5, day: 20).date, isUnlocked: true),
        Achievement(name: "Fifth training", imageName: "trophyOff", isUnlocked: false),
        Achievement(name: "Tenth training", imageName: "trophyOff", isUnlocked: false)
    ]
    
}
