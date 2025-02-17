//
//  SplashScreenView.swift
//  HamiltonCity
//
//  Created by Tassos Fergadiotis on 2025-02-17.
//

import SwiftUI
import SwiftData

struct SplashScreenView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistering = false
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            
            VStack {
                Image("Splash_background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.3)
                
                Text("Welcome to Hamilton")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if isRegistering {
                    TextField("Username", text: $username) // Fixed: separate username field
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Register") {
                        userManager.register(username: username, email: email, password: password)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                } else {
                    Button("Login") {
                        if userManager.login(email: email, password: password) {
                            print("Login successful")
                        } else {
                            print("Invalid credentials")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                
                Button(isRegistering ? "Go to Login" : "Create an Account") {
                    isRegistering.toggle()
                }
                .padding()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView().environmentObject(UserManager())
    }
}

