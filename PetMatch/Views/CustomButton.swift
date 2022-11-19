//
//  CustomButton.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/17/22.
//

import Foundation
import UIKit

enum ThemeButtonType {
    case primary
    case secondary
}
extension UIButton {
    func configure(type: ThemeButtonType) {
        switch type {
        case .primary:
            self.backgroundColor = ThemeColor.with(color: .primaryColor)
            self.setTitleColor(ThemeColor.with(color: .primaryTextColor), for: .normal)
            self.titleLabel?.font = UIFont(name: "Helvatice-Bold", size: 15)
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 8
        case .secondary:
            self.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
            self.backgroundColor = ThemeColor.with(color: .clearColor)
            self.setTitleColor(ThemeColor.with(color: .primaryColor), for: .normal)
          
        }
    }
}
