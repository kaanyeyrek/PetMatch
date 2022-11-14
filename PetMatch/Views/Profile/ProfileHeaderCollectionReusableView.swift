//
//  ProfileHeaderCollectionReusableView.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/8/22.
//

import UIKit
import SDWebImage

protocol ProfileHeaderCollectionInterface: AnyObject {
    func setupUI()
    func layout()
    func configure(with model: ProfileHeaderModel)
    
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileHeaderCollectionReusableView"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 55
        imageView.backgroundColor = .secondarySystemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        return imageView
    }()
    private let primaryButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .systemPink
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let followersButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("0\nFollowers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .secondarySystemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let followingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("0\nFollowing", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var viewModel: ProfileHeaderCollectionViewModelInterface = ProfileHeaderCollectionViewModel()
    
       
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.view = self
        viewModel.overrideinit()
        actionSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    func actionSetup() {
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
    }
    @objc private func didTapFollowersButton() {
        viewModel.didTapFollowersButton()
    }
    @objc private func didTapFollowingButton() {
        viewModel.didTapFollowingButton()
    }
    @objc private func didTapPrimaryButton() {
        viewModel.didTapPrimaryButton()
    }
    
}
//MARK: - ProfileHeaderCollectionInterface Delegate
extension ProfileHeaderCollectionReusableView: ProfileHeaderCollectionInterface {
    func setupUI() {
        self.addSubview(avatarImageView)
        self.addSubview(primaryButton)
        self.addSubview(followersButton)
        self.addSubview(followingButton)
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        self.backgroundColor = .systemBackground
        followersButton.sizeToFit()
        followingButton.sizeToFit()
        primaryButton.sizeToFit()
    }
    // Layout
    func layout() {
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -75),
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            avatarImageView.heightAnchor.constraint(equalToConstant: 110),
            
            followersButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            followersButton.centerXAnchor.constraint(equalTo: self.avatarImageView.rightAnchor, constant: 100),
            followersButton.widthAnchor.constraint(equalToConstant: 100),
            followersButton.heightAnchor.constraint(equalToConstant: 60),
            
            followingButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            followingButton.centerXAnchor.constraint(equalTo: self.followersButton.rightAnchor, constant: 70),
            followingButton.widthAnchor.constraint(equalToConstant: 100),
            followingButton.heightAnchor.constraint(equalToConstant: 60),
            
            primaryButton.topAnchor.constraint(equalTo: self.followingButton.bottomAnchor,constant: 20),
            primaryButton.centerXAnchor.constraint(equalTo: self.avatarImageView.rightAnchor, constant: 160),
            primaryButton.widthAnchor.constraint(equalToConstant: 220),
            primaryButton.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
   
  //MARK: - Configure for header cell
    func configure(with model: ProfileHeaderModel) {
        followersButton.setTitle("\(model.followers)\nFollowers", for: .normal)
        followingButton.setTitle("\(model.following)\nFollowers", for: .normal)
        // SDWebImage avatarURL
        if let avatarURL = model.avatarImage {
            avatarImageView.sd_setImage(with: avatarURL, completed: nil)
        } else {
            avatarImageView.image = UIImage(named: "dog2")
        }
        if let isFollowing = model.isFollowing {
            primaryButton.setTitleColor(isFollowing ? .label : .white, for: .normal)
            primaryButton.backgroundColor = isFollowing ? .secondarySystemBackground : .systemBlue
            primaryButton.setTitle(isFollowing ? "Unfollow" : "Follow", for: .normal
            )

        } else {
            primaryButton.setTitleColor(.white , for: .normal)
            primaryButton.backgroundColor = .secondarySystemBackground
            primaryButton.setTitle("Edit Profile", for: .normal)
        }
    }

}
