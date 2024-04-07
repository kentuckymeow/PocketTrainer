//
//  SelectedExersiseView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 07.04.2024.
//

import SwiftUI
import AVKit

struct SelectedExersiseView: View {
    var exercise: Exercise
    
    var body: some View {
            VStack {
                Text(exercise.name)
                VideoPlayer(player: AVPlayer(url:
                    Bundle.main.url(forResource: exercise.videoUrl, withExtension:"mp4")!))
                    
                Text(exercise.description)
                    .padding()
            }
        }
}

#Preview {
    SelectedExersiseView(exercise: Exercise(name: "Base Crossfit", sets: "4x10", imageName: "BenchPress", videoUrl: "video", description: ""))
}
