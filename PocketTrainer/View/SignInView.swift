//
//  SignInView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 25.03.2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel = SignInViewModel()
    var body: some View {
        VStack(spacing: 30) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(CustomTextFieldStyle())
            TextField("Password", text: $viewModel.password)
                .textFieldStyle(CustomTextFieldStyle())
            
            Button("Sign In") {}
                .frame(width: 200,height: 60)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding()
        }
    }
}

#Preview {
    SignInView()
}
