//
//  PostModel.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/8/22.
//

import Foundation

struct PostModel {
    let user: UserModel
    var identifier: String
    var isLikedByCurrentUser = false
    
    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(user: UserModel(userName: "victoria", profilePictureURL: nil, identifier: UUID().uuidString), identifier: UUID().uuidString, isLikedByCurrentUser: false)
            posts.append(post)
        }
        return posts
    }
        
}
