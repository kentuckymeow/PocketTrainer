//
//  BackButton.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 12.05.2024.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }
    }
}

#Preview {
    BackButton(action: {print("tapped")})
}
