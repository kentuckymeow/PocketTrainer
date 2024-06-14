//
//  PocketTrainerApp.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 24.03.2024.
//

import SwiftUI

@main
struct PocketTrainerApp: App {
    init() {
            // Устанавливаем русскую локаль для всего приложения
            UserDefaults.standard.set(["ru_RU"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    var body: some Scene {
        WindowGroup {
            RegistrationView()
        }
    }
}
