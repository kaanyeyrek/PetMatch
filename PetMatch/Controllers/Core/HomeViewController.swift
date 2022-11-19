//
//  ViewController.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/3/22.
//

import UIKit
import CardSlider
import SafariServices

class HomeViewController: UIViewController, CardSliderDataSource {
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "dogLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let appLabel: UILabel = {
        let label = UILabel()
        label.text = "PET MATCH"
        label.font = UIFont(name: "Copperplate", size: 30.0)
        label.textColor = .label
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let showCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lets go, Show Card!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .label
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let TermsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms Of Service", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    private var data = [CardItem]()
//MARK: - LifeCycle
//Onboarding Flow
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
        if AuthManager.shared.isNewUser() {
            let vc = OnboardingViewController()
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupData()
        setupButton()
        setupLayout()
    }
// Subviews and Actions
    private func setupButton() {
        view.addSubview(logoImage)
        view.addSubview(appLabel)
        view.addSubview(showCardButton)
        view.addSubview(privacyButton)
        view.addSubview(TermsButton)

        showCardButton.addTarget(self, action: #selector(didTapShowCardButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        TermsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
    }
// Show Card VC for pod
    @objc private func didTapShowCardButton() {
        let vc = CardSliderViewController.with(dataSource: self)
        vc.title = "Welcome!"
        navigationController?.pushViewController(vc, animated: true)
    }
// Tap PrivacyButton
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://policies.tinder.com/terms/intl/tr") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
// Tap TermsButton
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://policies.tinder.com/privacy/intl/tr") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
                
    }
// Constraints
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            appLabel.widthAnchor.constraint(equalToConstant: 200),
            appLabel.heightAnchor.constraint(equalToConstant: 60),
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLabel.bottomAnchor.constraint(equalTo: logoImage.topAnchor, constant: -40),
    
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.bottomAnchor.constraint(equalTo: showCardButton.topAnchor, constant: -40),
            
            showCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showCardButton.heightAnchor.constraint(equalToConstant: 50),
            showCardButton.widthAnchor.constraint(equalToConstant: 200),
            showCardButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyButton.heightAnchor.constraint(equalToConstant: 50),
            privacyButton.widthAnchor.constraint(equalToConstant: 200),
            privacyButton.topAnchor.constraint(equalTo: showCardButton.bottomAnchor, constant: 200),
            
            TermsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TermsButton.heightAnchor.constraint(equalToConstant: 50),
            TermsButton.widthAnchor.constraint(equalToConstant: 200),
            TermsButton.topAnchor.constraint(equalTo: showCardButton.bottomAnchor, constant: 250)
        ])
    }
// Data Informations
    private func setupData() {
        data.append(CardItem(image: UIImage(named: "dog1")!, rating: nil, title: "Golden", subtitle: "6 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog2")!, rating: nil, title: "White Pug", subtitle: "13 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog3")!, rating: nil, title: "Black Pug", subtitle: "2 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog4")!, rating: nil, title: "Pitbull", subtitle: "10 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog1")!, rating: nil, title: "Golden", subtitle: "6 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog2")!, rating: nil, title: "White Pug", subtitle: "13 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog3")!, rating: nil, title: "Black Pug", subtitle: "2 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog4")!, rating: nil, title: "Pitbull", subtitle: "10 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog1")!, rating: nil, title: "Golden", subtitle: "6 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog2")!, rating: nil, title: "White Pug", subtitle: "13 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog3")!, rating: nil, title: "Black Pug", subtitle: "2 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog4")!, rating: nil, title: "Pitbull", subtitle: "10 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
    }
    //MARK: - CardSlider Methods
    func item(for index: Int) -> CardSliderItem {
        return data[index]
    }

    func numberOfItems() -> Int {
        return data.count
    }
}

