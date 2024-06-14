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
            VStack(spacing: 20) {
                Spacer()
                
                Text(exercise.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                VideoPlayer(player: AVPlayer(url: URL(string: exercise.video)!))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                Text(exercise.description)
                    .font(.body)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { self.presentationMode.wrappedValue.dismiss() }))
        .toolbar(.hidden, for: .tabBar)
    }
}



#Preview {
    SelectedExerciseView(exercise: Exercise(id: 1, name: "Base Crossfit", sets: "4x10", image: "BenchPress", video: "video", description: """
                                                                 "How to do a bench press
                                                                 Equipment needed: barbell (additional weights optional) or dumbbells, flat bench
                                                                Lie on your back on a flat bench. Grip a barbell with hands slightly wider than shoulder width. The bar should be directly over the shoulders.
                                                                Press your feet firmly into the ground and keep your hips on the bench throughout the entire movement.
                                                                 Keep your core engaged and maintain a neutral spine position throughout the movement. Avoid arching your back.
                                                                Slowly lift the bar or dumbbells off the rack, if using. Lower the bar to the chest, about nipple level, allowing elbows to bend out to the side, about 45 degrees away from the body.
                                                                 Stop lowering when your elbows are just below the bench. Press feet into the floor as you push the bar back up to return to starting position.
                                                                Perform 5 to 10 reps, depending on weight used. Perform up to 3 sets.
                                                                """))
}
