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
        
    init(training: Training) {
        self.training = training
        self._player = State(initialValue: AVPlayer(url: URL(fileURLWithPath:
        Bundle.main.path(forResource: training.videoUrl, ofType: "mp4")!)))
    }
    
    var body: some View {
        ZStack{
            VideoPlayer(player: player) {VStack{}}
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .onAppear() {
                    player.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                        player.seek(to: .zero)
                        player.play()
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    player.play()
                }
                .onDisappear(){
                    player.pause()
                }
                .allowsHitTesting(false)
            
            VStack {

                Text(training.name)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Duration: \(training.time)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(training.description)
                    .foregroundColor(.white)
                    .font(.body)
                    .padding()
                
                NavigationLink(destination: WorkoutView(training: training)) {
                    Text("Start")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 50)
            }
            .padding()
        }
    }
}


//#Preview {
//    WorkoutDetailView(training: Training(name: "Bodybuilding", time: "30 min", imageName: "crossfit", description: "КУШАЦ СПАТЬ КАЧАЦА", videoUrl: "sam2", exercises: [
//        Exercise(name: "Bench press", sets: "4x10", imageName: "BenchPress",videoUrl: "Bench press", description:""),
//        Exercise(name: "Seated dumbbell press", sets: "4x10", imageName: "DumbbellPress",videoUrl: "", description:""),
//    ]))
//}
