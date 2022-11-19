//
//  RegisterViewController.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/17/22.
//
import UIKit
protocol RegisterViewControllerInterface: AnyObject {
    func configureUI()
    func configureButton()
    func layout()
    func setNavigateToLogin(_ vc: UIViewController)
    func tabBarSet()
    func resignFirst()
    func showAlert()
    func gestureAvatar()
    func showActionSheet()
    
    var firstField: String? { get }
    var lastField: String? { get }
    var emailField: String? { get }
    var passwordField: String? { get }
}

final class RegisterViewController: UIViewController {
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.crop.circle")
        image.tintColor = .gray
        image.layer.cornerRadius = 55
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.lightGray.cgColor
        return image
    }()
    private let firstNameField = Authfield(type: .firstName)
    private let lastNameField = Authfield(type: .lastName)
    private let emailTextField = Authfield(type: .email)
    private let passwordTextField = Authfield(type: .password)
    private let signUpButton = AuthButton(type: .signUp, title: nil)
   
    

    private lazy var viewModel: RegisterViewModelInterface = RegisterViewModel()
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
    @objc private func didTapAvatar(_ button: UIButton) {
        viewModel.didTapAvatar()
    }
}
//MARK: - LoginViewInterface Delegate
extension RegisterViewController: RegisterViewControllerInterface {
    var firstField: String? {
        firstNameField.text
    }
    
    var lastField: String? {
        lastNameField.text
    }
    
    var emailField: String? {
        emailTextField.text
    }
    
    var passwordField: String? {
        passwordTextField.text
    }
    func gestureAvatar() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar(_:)))
        profileImageView.addGestureRecognizer(gesture)
        profileImageView.isUserInteractionEnabled = true
      
    }
    
    func configureUI() {
        title = "Create Account"
        emailTextField.delegate = self
        passwordTextField.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(signUpButton)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(profileImageView)
    }
    func configureButton() {
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
    }
    func layout() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -230),
            profileImageView.widthAnchor.constraint(equalToConstant: 110),
            profileImageView.heightAnchor.constraint(equalToConstant: 110),
            
            firstNameField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50),
            firstNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameField.widthAnchor.constraint(equalToConstant: 350),
            firstNameField.heightAnchor.constraint(equalToConstant: 50),
            
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 20),
            lastNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastNameField.widthAnchor.constraint(equalToConstant: 350),
            lastNameField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 350),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    func setNavigateToLogin(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    func tabBarSet() {
        tabBarController?.tabBar.isHidden = true
    }
    func resignFirst() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    func showAlert() {
        let alert = UIAlertController(title: "Woops!", message: "Please enter correct all information to log in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        present(actionSheet, animated: true)
    }
}

// MARK: - UITextField Delegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            viewModel.didTapSignUpButton()
        }
        return true
    }
}
//MARK: - UIImagePicker Delegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    private func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        present(vc, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.profileImageView.image = selectedImage
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    
}
