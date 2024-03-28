//
//  ExerciseView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 27.03.2024.
//

// ExerciseView.swift
import SwiftUI

struct ExerciseView: View {
    @State var currentTab: Int = 0
    @Namespace var namespace

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab, content: {
                WorkoutSelectionView().tag(0)
                FavouriteWorkoutsView().tag(1)
            })
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)
            NavigationBarView(currentTab: $currentTab, namespace: _namespace)
        }
    }
}


#Preview {
    ExerciseView()
}
