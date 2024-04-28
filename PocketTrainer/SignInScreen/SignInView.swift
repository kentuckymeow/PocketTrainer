//
//  SignInView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 25.03.2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel = SignInViewModel()
    @ObservedObject var alertManager = AlertManager()
    @State private var isActive = false

    var body: some View {
        VStack(spacing: 30) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(CustomTextFieldStyle())
            TextField("Password", text: $viewModel.password)
                .textFieldStyle(CustomTextFieldStyle())
            
            NavigationLink(destination: ContentView(), isActive: $isActive) {
                Button {
                    didTapSignIn()
                } label: {
                    Text("Sign In")
                        .frame(width: 200,height: 60)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding()
                }
            }
        }
        .alert(item: $alertManager.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message), dismissButton: .default(Text("Dismiss")))
        }
    }
    
    func didTapSignIn() {
        let userRequest = SignInUserModel(
            email: viewModel.email,
            password: viewModel.password
        )
        
        // Email check
        if !Validator.isValidEmail(for: userRequest.email) {
            alertManager.showInvalidEmailAlert()
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: userRequest.password) {
            alertManager.showInvalidPasswordAlert()
            return
        }
        
        guard let request = Endpoint.signIn(userRequest: userRequest).request else { return }
        AuthService.fetch(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.isActive = true
                    
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                        alertManager.showSignInErrorAlert(with: string)
                    }
                }
            }
        }
    }
}


#Preview {
    SignInView()
}
