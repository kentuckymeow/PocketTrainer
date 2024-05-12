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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            VStack {
                Text(exercise.name)
                VideoPlayer(player: AVPlayer(url:
                    Bundle.main.url(forResource: exercise.video, withExtension:"mp4")!))
                    
                Text(exercise.description)
                    .padding()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: { self.presentationMode.wrappedValue.dismiss() }))
        }
}

//#Preview {
//    SelectedExersiseView(exercise: Exercise(name: "Base Crossfit", sets: "4x10", imageName: "BenchPress", videoUrl: "video", description: ""))
//}
