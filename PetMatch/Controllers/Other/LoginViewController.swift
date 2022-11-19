//
//  LoginViewController.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/17/22.
//

import UIKit
protocol LoginViewControllerInterface: AnyObject {
    func resignFirst()
    func configureUI()
    func configureButton()
    func showAlert()
    func layout()
    func setNavigateToLogin(_ vc: UIViewController)
    func tabBarSet()
    var emailText: String? { get }
    var passwordText: String? { get }
    
}

final class LoginViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "dogLogo")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let emailTextField = Authfield(type: .email)
    private let passwordTextField = Authfield(type: .password)
    private let signInButton = AuthButton(type: .signIn, title: nil)
    private let signUpButton = AuthButton(type: .plain, title: "Create New Account?")
    private let forgotPasswordButton = AuthButton(type: .plain, title: "Forgot Password?")
    

    private lazy var viewModel: LoginViewModelInterface = LoginViewModel()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    //MARK: - Actions
    @objc private func didTapSignUpButton(_ button: UIButton) {
        viewModel.didTapSignUpButton()
    }
    @objc private func didTapSignInButton(_ button: UIButton) {
        viewModel.didTapSignInButton()
    }
    @objc private func didTapForgotPasswordButton(_ button: UIButton) {
        viewModel.didTapForgotPasswordButton()
    }

}
//MARK: - LoginViewInterface Delegate
extension LoginViewController: LoginViewControllerInterface {
    func resignFirst() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    var emailText: String? {
        emailTextField.text
    }
    var passwordText: String? {
        passwordTextField.text
    }
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(logoImageView)
    }
    func configureButton() {
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(didTapSignInButton(_:)), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton(_:)), for: .touchUpInside)
    }
    func layout() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -175),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 350),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 350),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 5),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 350),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    func setNavigateToLogin(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    func tabBarSet() {
        tabBarController?.tabBar.isHidden = true
    }
    func showAlert() {
        let alert = UIAlertController(title: "Woops!", message: "Please enter correct all information to log in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
