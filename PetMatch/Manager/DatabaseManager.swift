//
//  DatabaseManager.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/6/22.
//

import Foundation

final class DatabaseManager {
// Singleton Instance
    static let shared = DatabaseManager()
// Fetch for completion mockData
    public func getNotifications(completion: @escaping ([Notification]) -> Void) {
        completion(Notification.mockData())
    }
    public func getPost(for user: UserModel, completion: @escaping ([PostModel]) -> Void) {
        completion(PostModel.mockModels())
    }
    
}


