//
//  AlertManager.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 21.04.2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String
}

class AlertManager: ObservableObject {
    @Published var alertItem: AlertItem?
    
    func showBasicAlert(title: String, message: String) {
        alertItem = AlertItem(title: title, message: message)
    }
}

// MARK: - Show Validation Alerts
extension AlertManager {
    
    func showInvalidEmailAlert() {
        showBasicAlert(title: "Invalid Email", message: "Please enter a valid email.")
    }
    
    func showInvalidPasswordAlert() {
        showBasicAlert(title: "Invalid Password", message: "Please enter a valid password.")
    }
    
    func showInvalidUsernameAlert() {
        showBasicAlert(title: "Invalid Username", message: "Please enter a valid username.")
    }
    
    func showPasswordsDoNotMatchAlert() {
        showBasicAlert(title: "Passwords Do Not Match", message: "Please make sure your passwords match.")
    }
}

// MARK: - Registration Errors
extension AlertManager {
    
    func showRegistrationErrorAlert() {
        showBasicAlert(title: "Unknown Registration Error", message: "")
    }
    
    func showRegistrationErrorAlert(with error: String) {
        showBasicAlert(title: "Unknown Registration Error", message: error)
    }
}

// MARK: - Log In Errors
extension AlertManager {
    
    func showSignInErrorAlert() {
        showBasicAlert(title: "Unknown Error Signing In", message: "")
    }
    
    func showSignInErrorAlert(with error: String) {
        showBasicAlert(title: "Error Signing In", message: error)
    }
}

// MARK: - Logout Errors
extension AlertManager {
    
    func showLogoutError(with error: Error) {
        showBasicAlert(title: "Log Out Error", message: "\(error.localizedDescription)")
    }
}

// MARK: - Forgot Password
extension AlertManager {

    func showPasswordResetSent() {
        showBasicAlert(title: "Password Reset Sent", message: "")
    }
    
    func showErrorSendingPasswordReset(with error: String) {
        showBasicAlert(title: "Error Sending Password Reset", message: error)
    }
}

// MARK: - Fetching User Errors
extension AlertManager {
    
    func showFetchingUserError(with error: Error) {
        showBasicAlert(title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
    
    func showUnknownFetchingUserError() {
        showBasicAlert(title: "Unknown Error Fetching User", message: "")
    }
}
