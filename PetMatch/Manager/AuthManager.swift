//
//  AuthManager.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/16/22.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
        
    }
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
