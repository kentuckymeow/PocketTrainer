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
    @State private var showPassword = false
    @State private var showRepeatPassword = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(spacing: 30) {
            TextField("Электронная почта", text: $viewModel.email)
                .textFieldStyle(CustomTextFieldStyle())

            ZStack(alignment:.trailing) {
                if showPassword {
                    TextField("Пароль", text: $viewModel.password)
                } else {
                    SecureField("Пароль", text: $viewModel.password)
                }
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing,16)
                }
            }
            .textFieldStyle(CustomTextFieldStyle())

            ZStack(alignment:.trailing) {
                if showRepeatPassword {
                    TextField("Повторите пароль", text: $viewModel.repeatPassword)
                } else {
                    SecureField("Повторите пароль", text: $viewModel.repeatPassword)
                }
                Button(action: {
                    showRepeatPassword.toggle()
                }) {
                    Image(systemName: showRepeatPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing,16)
                }
            }
            .textFieldStyle(CustomTextFieldStyle())

            Text("Пароль должен содержать от 6 до 32 символов, включать как минимум одну заглавную букву, одну строчную букву, одну цифру и один специальный символ.")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.horizontal)

            NavigationLink(destination: ContentView(viewModel: HealthDataViewModel()), isActive: $isActive) {
                Button {
                    didTapSignUp()
                } label: {
                    Text("Присоединяйтесь к нам")
                        .frame(width: 250, height: 60)
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
                         .unknown(let string),
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
