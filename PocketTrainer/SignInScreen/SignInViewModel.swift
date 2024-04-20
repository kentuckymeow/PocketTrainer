//
//  SignInViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 25.03.2024.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func register() {
        print("email:\(email)")
        print("password:\(password)")
    }
}

