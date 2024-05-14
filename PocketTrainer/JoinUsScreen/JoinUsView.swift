//
//  JoinUsView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 25.03.2024.
//

import SwiftUI

struct JoinUsView: View {
    @ObservedObject var viewModel = JoinUsViewModel()
    @ObservedObject var alertManager = AlertManager()
    @State private var isActive = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(spacing: 30) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(CustomTextFieldStyle())
            TextField("Password", text: $viewModel.password)
                .textFieldStyle(CustomTextFieldStyle())
            TextField("Repeat password", text: $viewModel.repeatPassword)
                .textFieldStyle(CustomTextFieldStyle())
            
            NavigationLink(destination: ContentView(viewModel: HealthDataViewModel()), isActive: $isActive) {
                Button {
                    didTapSignUp()
                } label: {
                    Text("Join Us")
                        .frame(width: 200,height: 60)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { self.presentationMode.wrappedValue.dismiss() }))
        .alert(item: $alertManager.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message), dismissButton: .default(Text("Dismiss")))
        }
    }
    
    func didTapSignUp() {
        let userRequest = RegisterUserModel(
            email: viewModel.email,
           // username: viewModel.name,
            password: viewModel.password
        )
        
//        // Username check
//        if !Validator.isValidUsername(for: userRequest.username) {
//            alertManager.showInvalidUsernameAlert()
//            return
//        }
        
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
        
        // Passwords match check
        if viewModel.password != viewModel.repeatPassword {
            alertManager.showPasswordsDoNotMatchAlert()
            return
        }
        
        guard let request = Endpoint.createAccount(userRequest: userRequest).request else { return }
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
                        alertManager.showRegistrationErrorAlert(with: string)
                    }
                }
            }
        }
    }
}

#Preview {
    JoinUsView()
}
