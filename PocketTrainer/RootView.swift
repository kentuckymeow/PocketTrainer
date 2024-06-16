//
//  RootView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 16.06.2024.
//

import SwiftUI

struct RootView: View {
//    @AppStorage("onboardingScreenShown")
//    var onboardingScreenShown: Bool = false
    
    var body: some View {
        if UserDefaults.standard.onboardingScreenShown{
            RegistrationView()
        } else {
            OnboardingView()
        }
    }
}

extension UserDefaults {
    var onboardingScreenShown: Bool {
        get {
            return( UserDefaults.standard.value(forKey: "onboardingScreenShown") as? Bool) ?? false
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "onboardingScreenShown")
        }
    }
}

#Preview {
    RootView()
}
