//
//  WorkoutView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 29.03.2024.
//

import SwiftUI

struct WorkoutView: View {
    var training: Training
    var body: some View {
        Text(training.name)
            .navigationTitle(training.name)
    }
}

#Preview {
    WorkoutView(training: Training(name: "Base Crossfit", time: "30 min", imageName: "crossfit"))
}
