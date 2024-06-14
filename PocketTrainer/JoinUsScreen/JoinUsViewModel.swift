//
//  JoinUsViewModel.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 25.03.2024.
//

import Foundation

class JoinUsViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    
    func register() {
        print("email:\(email)")
        print("password:\(password)")
    }
}
