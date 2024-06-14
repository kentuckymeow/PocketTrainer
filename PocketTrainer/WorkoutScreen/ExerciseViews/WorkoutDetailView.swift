//
//  StartView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 08.05.2024.
//

import SwiftUI
import AVKit

struct WorkoutDetailView: View {
    let training: Training
    @State private var player: AVPlayer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    init(training: Training) {
        self.training = training
        self._player = State(initialValue: AVPlayer(url: URL(string: training.videoUrl)!))
    }
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .onAppear() {
                    player.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                        player.seek(to: .zero)
                        player.play()
                    }
                }
                .onDisappear() {
                    player.pause()
                }
                .allowsHitTesting(false)
            
            VStack {
                ZStack {
                    VStack {
                        Text(training.name)
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                        
                        Text("Продолжительность: \(training.duration) минут")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 20)
                        
                        Text(training.description)
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(.horizontal, 10)
                            .frame(maxWidth: 250)
                            .padding(.vertical, 5)
                            .multilineTextAlignment(.center)
                        
                        
                        NavigationLink(destination: WorkoutView(training: training)) {
                            Text("Начать тренировку")
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 20,
                                        style: .continuous
                                    )
                                    .stroke(Color.white, lineWidth: 3)
                                )
                                .padding()
                        }
                        .padding(.top, 50)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .padding(.horizontal, 20)
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: { self.presentationMode.wrappedValue.dismiss() }))
        }
    }
}

#Preview {
    WorkoutDetailView(training: Training(id: 1, name: "Bodybuilding", duration: 30, imageUrl: "crossfit", description: "Bodybuilding training focuses on developing muscle size, symmetry, and definition through a combination of weightlifting, resistance exercises", videoUrl: "sam", WorkoutToExercise: [
                WorkoutToExercise(id: 1, workoutId: 1, exerciseId: 1, exercise: Exercise(id: 1, name: "Bench press", sets: "4x10", image: "BenchPress",video: "Bench press", description:"")),
                WorkoutToExercise(id: 2, workoutId: 1, exerciseId: 2, exercise: Exercise(id: 2, name: "Seated dumbbell press", sets: "4x10", image: "DumbbellPress",video: "", description:"")),
            ]))
}

