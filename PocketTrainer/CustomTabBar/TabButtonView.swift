//
//  TabButtonView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct TabButton: View {
    @Binding var selectedTab: Tab
    let tab: Tab
    let imageName: String
    
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            Image(selectedTab == tab ? "\(imageName)On" : "\(imageName)Off")
                .resizable()
                .scaledToFit()
                .frame(width: 35,height: 35)
        }
    }
}
