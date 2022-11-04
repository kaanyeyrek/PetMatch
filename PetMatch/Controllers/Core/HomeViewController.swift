//
//  ViewController.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/3/22.
//

import UIKit
import CardSlider

class HomeViewController: UIViewController, CardSliderDataSource {
    
    private let showCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lets go, Show Card!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var data = [CardItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        setupData()
        setupButton()
        setupLayout()
    }

    private func setupButton() {
        view.addSubview(showCardButton)
        showCardButton.addTarget(self, action: #selector(didTapShowCardButton), for: .touchUpInside)
    }

    @objc private func didTapShowCardButton() {
        let vc = CardSliderViewController.with(dataSource: self)
        vc.title = "Welcome!"
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            showCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showCardButton.heightAnchor.constraint(equalToConstant: 50),
            showCardButton.widthAnchor.constraint(equalToConstant: 200),
            showCardButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
    }

    private func setupData() {
        data.append(CardItem(image: UIImage(named: "dog1")!, rating: nil, title: "Golden", subtitle: "6 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog2")!, rating: nil, title: "White Pug", subtitle: "13 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog3")!, rating: nil, title: "Black Pug", subtitle: "2 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
        data.append(CardItem(image: UIImage(named: "dog4")!, rating: nil, title: "Pitbull", subtitle: "10 years old", description: "I want to adopt someone who can take responsibility for the dogs"))
    }

    func item(for index: Int) -> CardSliderItem {
        return data[index]
    }

    func numberOfItems() -> Int {
        return data.count
    }
}

