//
//  ThemeColor.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/17/22.
//

import Foundation
import UIKit

struct ThemeColor {
    
    enum Color {
        case bodyTextColor
        case primaryColor
        case primaryTextColor
        case viewBackgroundColor
        case clearColor
    }
    static func with(color: Color) -> UIColor {
        switch color {
        case .bodyTextColor:
            return .black
        case .primaryColor:
            return UIColor(red: 65/255, green: 146/255, blue: 238/255, alpha: 1)
        case .primaryTextColor:
            return .white
        case .clearColor:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        case .viewBackgroundColor:
            return UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        }
        
    }
    
}
