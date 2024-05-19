//
//  SelectedExersiseView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 07.04.2024.
//

import SwiftUI
import AVKit

struct SelectedExerciseView: View {
    var exercise: Exercise
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack {
                Text(exercise.name)
                VideoPlayer(player: AVPlayer(url: URL(string: exercise.video)!))
                    .frame(height: 300)
                Text(exercise.description)
                    .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { self.presentationMode.wrappedValue.dismiss() }))
        .toolbar(.hidden,for: .tabBar)
    }
}


#Preview {
    SelectedExerciseView(exercise: Exercise(id: 1, name: "Base Crossfit", sets: "4x10", image: "BenchPress", video: "video", description: ""))
}
