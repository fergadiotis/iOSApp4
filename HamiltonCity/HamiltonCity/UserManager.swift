//
//  UserManager.swift
//  HamiltonCity
//
//  Created by Tassos Fergadiotis on 2025-02-17.
//

import Foundation
import SwiftUI
import SwiftData

struct User: Codable, Identifiable {
    var id: UUID = UUID()
    var username: String
    var email: String
    var password: String
}

class UserManager: ObservableObject {
    @Published var users: [User] = []
    @Published var currentUser: User? = nil
    
    private let userDefaultsKey = "savedUsers"

    init() {
        loadUsers()
    }
    
    func loadUsers() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([User].self, from: savedData) {
            users = decoded
        } else if let url = Bundle.main.url(forResource: "users", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let decoded = try? JSONDecoder().decode([User].self, from: data) {
            users = decoded
            saveUsers() // Save JSON users to UserDefaults so they persist
        }
    }
    
    func saveUsers() {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func register(username: String, email: String, password: String) {
        let newUser = User(username: username, email: email, password: password)
        users.append(newUser)
        saveUsers()
        currentUser = newUser
    }
    
    func login(email: String, password: String) -> Bool {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            currentUser = user
            return true
        }
        return false
    }
}

