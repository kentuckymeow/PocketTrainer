//
//  JoinUsView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 25.03.2024.
//

import SwiftUI

struct JoinUsView: View {
    @ObservedObject var viewModel = JoinUsViewModel()
    var body: some View {
        VStack(spacing: 30) {
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(CustomTextFieldStyle())
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(CustomTextFieldStyle())
            TextField("Password", text: $viewModel.password)
                .textFieldStyle(CustomTextFieldStyle())
            TextField("Repeat password", text: $viewModel.repeatPassword)
                .textFieldStyle(CustomTextFieldStyle())
            
            NavigationLink(destination: ExerciseView()) {
                Text("Join Us")
                .frame(width: 200,height: 60)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding()
            }
        }
    }
}

#Preview {
    JoinUsView()
}
