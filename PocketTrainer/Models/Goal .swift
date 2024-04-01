//
//  Goal .swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 31.03.2024.
//

import Foundation

struct Goal: Identifiable {
    var id = UUID()
    var name: String
    var weight: String
    var reps: String
    var sets: String
    var date: Date
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
