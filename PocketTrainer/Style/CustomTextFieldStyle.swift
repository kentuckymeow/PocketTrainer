//
//  CustomTextFieldStyle.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 25.03.2024.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(width: 300)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black)
            )
    }
}

