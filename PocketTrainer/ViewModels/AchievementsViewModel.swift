//
//  AchievementsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 30.03.2024.
//

import Foundation

class AchievementsViewModel:ObservableObject {
    @Published var achievements = [
        Achievement(name: "First training", imageName: "trophyOn", dateOfCollect: DateComponents(calendar: .current,year: 2003, month: 3, day: 13).date, isUnlocked: true),
        Achievement(name: "Fith training", imageName: "trophyOff", isUnlocked: false),
        Achievement(name: "Tenth training", imageName: "trophyOff", isUnlocked: false)
    ]
    
}
