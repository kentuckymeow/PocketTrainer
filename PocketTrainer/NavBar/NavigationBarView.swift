//
//  NavigationBarView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

// NavigationBarView.swift
import SwiftUI

struct NavigationBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    var navigationitems: [String] = ["Workout selection", "Favourite workouts"]

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 30){
                ForEach(Array(zip(self.navigationitems.indices, self.navigationitems)), id: \.0, content: {
                    index, name in
                    navBarItem(string: name, tab: index)
                        .padding(.horizontal)
                })
            }
            .padding(.horizontal, 30)
        }
        .background(Color.white)
        .frame(height: 80)
        .edgesIgnoringSafeArea(.top)
    }

    func navBarItem(string: String, tab: Int) -> some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(string)
                    .font(.system(size: 13, weight: .bold, design: .default))
                if self.currentTab == tab {
                    Color.black.frame(height: 4)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }.animation(.spring(), value: currentTab)
        }
        .buttonStyle(.plain)
    }
}

