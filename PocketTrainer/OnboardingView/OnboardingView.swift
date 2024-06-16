//
//  SwiftUIView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 16.06.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    var imageName: String
    var title: String
    var description: String

    @State private var animationAmount: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.9, blue: 0.9)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 300)
                    .offset(y: animationAmount)
                    .animation(
                        Animation
                            .easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                    )
                    .onAppear {
                        self.animationAmount = -40
                    }

                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                
                Text(description)
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var showRegistrationView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @AppStorage("onboardingViewShown")
    var onboardingViewSnown: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    TabView(selection: $currentPage) {
                        ForEach(0..<titles.count) { index in
                            OnboardingPageView(
                                imageName: "onboarding_\(index)",
                                title: titles[index],
                                description: descriptions[index]
                            )
                            .tag(index)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                           // .transition(.scale)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .animation(.easeInOut)
                    .transition(.slide)
                }
                
                NavigationLink(destination: RegistrationView(), isActive: $showRegistrationView) {
                    EmptyView()
                }
                .hidden()
                
                Button(action: {
                    withAnimation {
                        if currentPage < titles.count - 1 {
                            currentPage += 1
                        } else {
                            showRegistrationView = true
                        }
                    }
                }) {
                    Text(currentPage < titles.count - 1 ? "Далее" : "Начать")
                        .frame(width: 250, height: 60)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
            .onAppear(perform: {
                UserDefaults.standard.onboardingScreenShown = true
            })
        }
    }
    
    private let titles = [
        "Добро пожаловать в Карманный тренер!",
        "Управляйте своими тренировками",
        "Планируйте своё питание",
        "Записывай свой прогресс"
    ]
    
    private let descriptions = [
        "Краткое введение в приложение и его основные функции.",
        "Возможности планирования и отслеживания тренировок.",
        "Функционал для выбора и планирования питания.",
        "Отслеживание достижений и прогресса, установка и достижение фитнес-целей."
    ]
}


#Preview {
    OnboardingView()
}
