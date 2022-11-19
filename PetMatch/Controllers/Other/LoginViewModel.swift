//
//  LoginViewModel.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/17/22.
//

import Foundation
protocol LoginViewModelInterface {
    var view: LoginViewControllerInterface? { get set }
    func viewDidLoad()
    func didTapSignUpButton()
    func didTapSignInButton()
    func didTapForgotPasswordButton()
    
    
}

final class LoginViewModel {
    weak var view: LoginViewControllerInterface?
    
}
//MARK: - LoginViewModelInterface Delegate
extension LoginViewModel: LoginViewModelInterface {
    func viewDidLoad() {
        view?.configureUI()
        view?.layout()
        view?.configureButton()
        view?.tabBarSet()
    }
    func didTapSignInButton() {
        view?.resignFirst()
        view?.setNavigateToLogin(HomeViewController())
        if let text = view?.emailText, !text.isEmpty,
           !text.trimmingCharacters(in: .whitespaces).isEmpty,
           let password = view?.passwordText, !password.isEmpty,
           !password.trimmingCharacters(in: .whitespaces).isEmpty,
            password.count >= 6 {
            
        }
        else {
            view?.showAlert()
        }
        
    }
    func didTapSignUpButton() {
        view?.resignFirst()
        view?.setNavigateToLogin(RegisterViewController())
    }
    func didTapForgotPasswordButton() {
        print("forgot password")
    }
}
