//
//  Achievement.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 30.03.2024.
//

import Foundation

struct Achievement:Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
    var dateOfCollect: Date?
    var isUnlocked: Bool
}
