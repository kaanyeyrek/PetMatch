//
//  NotificationsUserTableViewCell.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/6/22.
//

import UIKit

class NotificationsUserTableViewCell: UITableViewCell {
    static let identifier = "NotificationsUserTableViewCell"

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var username: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(avatarImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        contentView.addSubview(dateLabel)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        selectionStyle = .none
        setupLayout()
    }

    @objc private func didTapFollowButton() {
        followButton.setTitle("Following", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.backgroundColor = .clear
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupLayout() {
        followButton.sizeToFit()
        label.sizeToFit()
        dateLabel.sizeToFit()
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            label.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 10),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            
            dateLabel.centerYAnchor.constraint(equalTo: label.bottomAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 110),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            followButton.widthAnchor.constraint(equalToConstant: 100),
            followButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        label.text = nil
        dateLabel.text = nil
        followButton.setTitle("Follow", for: .normal)
        followButton.backgroundColor = .systemBlue
        followButton.layer.borderColor = nil
        followButton.layer.borderWidth = 0
    }

    public func configure(with username: String, model: Notification) {
        self.username = username
        dateLabel.text = .date(with: model.date)
        label.text = model.text
        avatarImageView.image = UIImage(named: "dog2")
    }

}
