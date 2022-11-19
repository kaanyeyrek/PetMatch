//
//  RegisterViewModel.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/18/22.

import Foundation
protocol RegisterViewModelInterface {
    var view: RegisterViewControllerInterface? { get set }
    func viewDidLoad()
    func didTapSignUpButton()
    func didTapAvatar()
}

final class RegisterViewModel {
    weak var view: RegisterViewControllerInterface?
}

// MARK: - LoginViewModelInterface Delegate
extension RegisterViewModel: RegisterViewModelInterface {
    
    func viewDidLoad() {
        view?.configureUI()
        view?.layout()
        view?.configureButton()
        view?.tabBarSet()
        view?.gestureAvatar()
    }
    func didTapSignUpButton() {
        view?.resignFirst()
        view?.setNavigateToLogin(HomeViewController())

        if let firstName = view?.firstField, !firstName.isEmpty,
           !firstName.trimmingCharacters(in: .whitespaces).isEmpty,
           let lastName = view?.emailField, !lastName.isEmpty,
           !lastName.trimmingCharacters(in: .whitespaces).isEmpty,
           let emailText = view?.emailField, !emailText.isEmpty,
           !emailText.trimmingCharacters(in: .whitespaces).isEmpty,
           let password = view?.passwordField, !password.isEmpty,
           !password.trimmingCharacters(in: .whitespaces).isEmpty,
           password.count >= 6 {
            
        } else {
            view?.showAlert()
        }
    }
   
    func didTapAvatar() {
        view?.showActionSheet()
    }
    
}
