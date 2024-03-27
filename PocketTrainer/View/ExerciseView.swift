//
//  ExerciseView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 27.03.2024.
//

import SwiftUI

struct ExerciseView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                CustomTabBar()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ExerciseView()
}
