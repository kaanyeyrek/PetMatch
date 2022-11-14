//
//  NotificationsCommentTableViewCell.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/7/22.
//

import UIKit

class NotificationsCommentTableViewCell: UITableViewCell {

    static let identifier = "NotificationsCommentTableViewCell"
    
    private let postThumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var postId: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(postThumbnailImageView)
        contentView.addSubview(label)
        contentView.addSubview(dateLabel)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupLayout() {
        label.sizeToFit()
        dateLabel.sizeToFit()
        NSLayoutConstraint.activate([
            postThumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            postThumbnailImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            postThumbnailImageView.widthAnchor.constraint(equalToConstant: 60),
            postThumbnailImageView.heightAnchor.constraint(equalToConstant: 65),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            dateLabel.centerYAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.leftAnchor, constant: 117),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postThumbnailImageView.image = nil
        label.text = nil
        dateLabel.text = nil
    }
    public func configure(with postFileName: String, model: Notifications) {
        postId = postFileName
        postThumbnailImageView.image = UIImage(named: "dog1")
        label.text = model.text
        dateLabel.text = .date(with: model.date)
        
    }
}

