//
//  Authfield.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/18/22.
//
//MARK: - Custom Button
import UIKit

class Authfield: UITextField {

    enum FieldType {
        case email
        case password
        case firstName
        case lastName
        
        var title: String {
            switch self {
            case .email:
                return "Email Adress..."
            case .password:
                return "Password..."
            case .firstName:
                return "First Name..."
            case .lastName:
                return "Last Name..."
            }
        }
    }
    private let type: FieldType
        init(type: FieldType) {
            self.type = type
            super.init(frame: .zero)
            configure()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure() {
        if type == .password {
            isSecureTextEntry = true
            textContentType = .oneTimeCode
            
        } else if type == .email {
            keyboardType = .emailAddress
            textContentType = .emailAddress
        }
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
        layer.masksToBounds = true
        placeholder = type.title
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 100))
        leftViewMode = .always
        autocorrectionType = .no
        autocapitalizationType = .none
        returnKeyType = .done
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        
    }
}
    


