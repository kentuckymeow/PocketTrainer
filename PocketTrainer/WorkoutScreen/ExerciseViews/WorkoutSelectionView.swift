//
//  WorkoutSelectionView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct WorkoutSelectionView: View {
    @ObservedObject var viewModel: TrainingViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.trainings) { training in
                        NavigationLink(destination: WorkoutView(training: training)) {
                            ZStack(alignment: .bottomLeading) {
                                Image(training.imageName)
                                    .frame(height: 120)
                                    .cornerRadius(25)
                                VStack(alignment:.leading) {
                                    Text(training.name)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text("Duration: \(training.time)")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 0))

                                    
                            }
                            .padding(.vertical)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
    }
}


#Preview {
    WorkoutSelectionView(viewModel: TrainingViewModel())
}