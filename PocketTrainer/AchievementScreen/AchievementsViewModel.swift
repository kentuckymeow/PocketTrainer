//
//  AchievementsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 30.03.2024.
//

import Foundation

class AchievementsViewModel:ObservableObject {
    @Published var achievements = [
        Achievement(name: "Первая тренировка", imageName: "trophyOn", dateOfCollect: DateComponents(calendar: .current,year: 2024, month: 5, day: 20).date, isUnlocked: true),
        Achievement(name: "Пятая тренировка", imageName: "trophyOff", isUnlocked: false),
        Achievement(name: "Десятая тренировка", imageName: "trophyOff", isUnlocked: false)
    ]
    
}
