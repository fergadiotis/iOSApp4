//
//  HamiltonCityApp.swift
//  HamiltonCity
//
//  Created by Tassos Fergadiotis on 2025-02-09.
//

import SwiftUI

@main
struct HamiltonCityApp: App {
    @StateObject private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if userManager.currentUser != nil {
                    ContentView()
                        .environmentObject(userManager)
                } else {
                    SplashScreenView()
                        .environmentObject(userManager)
                }
            }
        }
    }
}
