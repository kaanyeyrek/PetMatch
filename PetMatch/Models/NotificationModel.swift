//
//  NotificationModel.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/6/22.
//

import Foundation
// NotificationType Cell
enum NotificationType {
    case postLike(postName: String)
    case userFollow(username: String)
    case postComment(postName: String)
    
    var id: String {
        switch self {
        case .postLike:
            return "postlike"
        case .userFollow:
            return "userFollow"
        case .postComment:
            return "postComment"
        }
    }
    
}
// Notification Model
class Notifications {
    var identifier = UUID().uuidString
    var text: String
    var date: Date
    let type: NotificationType
    
    init(text: String, date: Date, type: NotificationType) {
        self.text = text
        self.date = date
        self.type = type
    }
// Mock Data
    static func mockData() -> [Notifications] {
        let first = Array(0...10).compactMap({
            Notifications(text: "Something happened: \($0)", date: Date(), type: .userFollow(username: "kaanyeyrek"))
        })
        let second =  Array(0...10).compactMap({
            Notifications(text: "Something happened: \($0)", date: Date(), type: .postLike(postName: "victoria"))
        })
        let third = Array(0...10).compactMap({
            Notifications(text: "Something happened: \($0)", date: Date(), type: .postComment(postName: "shakira"))
        })
        return first + second + third
    }

    }

