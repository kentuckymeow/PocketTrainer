//
//  CustomTabBar.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 27.03.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 40) {
            TabButton(selectedTab: $selectedTab, tab: .exercise, imageName: "workout")
            TabButton(selectedTab: $selectedTab, tab: .achievements, imageName: "achievements")
            TabButton(selectedTab: $selectedTab, tab: .goals, imageName: "goal")
            TabButton(selectedTab: $selectedTab, tab: .nutrionPlan, imageName: "meal")
            TabButton(selectedTab: $selectedTab, tab: .profile, imageName: "user")
        }
        .padding(.vertical,10)
        .padding(.horizontal,20)
        .background(Color.white)
        .cornerRadius(25)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.exercise))
}
