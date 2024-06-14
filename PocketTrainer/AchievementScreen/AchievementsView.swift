//
//  AchievementsView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 28.03.2024.
//

import SwiftUI

struct AchievementsView: View {
    @ObservedObject var viewModel: AchievementsViewModel
    
    var body: some View {
        VStack {
            HStack(spacing:30) {
                ForEach(0..<viewModel.achievements.count, id: \.self) { index in
                    VStack {
                        Image(viewModel.achievements[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50 ,height: 50)
                        Text(viewModel.achievements[index].name)
                            .foregroundColor(viewModel.achievements[index].isUnlocked ? .black : .gray)
                            .multilineTextAlignment(.center)
                    
                        if viewModel.achievements[index].isUnlocked, let date = viewModel.achievements[index].dateOfCollect {
                            Text(date, style: .date)
                                .font(.caption)
                                .fontWeight(.ultraLight)
                                .foregroundColor(.primary)
                                .environment(\.locale,Locale.init(identifier: "ru"))
                        }
                    }
                }
            }
            Spacer()
        }
    }
    
}

#Preview {
    AchievementsView(viewModel: AchievementsViewModel())
}
