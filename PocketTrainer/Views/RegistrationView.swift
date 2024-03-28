//
//  ContentView.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 24.03.2024.
//

import SwiftUI

struct RegistrationView: View {
    var body: some View {
       NavigationView {
            ZStack {
                Image("registration")
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth:0 ,maxWidth: .infinity)
                VStack {
                    Spacer()
                    HStack {
                        NavigationLink(destination: JoinUsView()) {
                            Text("Join us")
                            .frame(width: 130,height: 60)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                            .padding()
                        }
                        NavigationLink(destination: SignInView()) {
                            Text("Sign In")
                            .frame(width: 130,height: 60)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 20,
                                    style: .continuous
                                )
                                .stroke(.white,lineWidth: 2)
                            )
                            .padding()
                        }
                        
                    }
                    .padding([.bottom],50)
                }
            }
            .padding()
       }
    }
}

#Preview {
    RegistrationView()
}
