//
//  CustomTabBar.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 27.03.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @State var selectedTab = 0
    
    var body: some View {
       
        HStack(spacing: 40) {
            Button {
                selectedTab = 0
            } label: {
                Image(selectedTab == 0 ? "workoutOn" : "workoutOff")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35,height: 35)
            }
            Button {
                selectedTab = 1
            } label: {
                Image(selectedTab == 1 ? "achievementsOn" : "achievementsOff")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35,height: 35)
            }
            Button {
                selectedTab = 2
            } label: {
                Image(selectedTab == 2 ? "goalOn" : "goalOff")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35,height: 35)
            }
            Button {
                selectedTab = 3
            } label: {
                Image(selectedTab == 3 ? "mealOn" : "mealOff")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35,height: 35)
            }
            Button {
                selectedTab = 4
            } label: {
                Image(selectedTab == 4 ? "userOn" : "userOff")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35,height: 35)
            }
        }
    }
}

#Preview {
    CustomTabBar()
}
