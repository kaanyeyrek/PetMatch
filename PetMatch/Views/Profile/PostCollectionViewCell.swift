//
//  PostCollectionViewCell.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/8/22.
//

import UIKit
protocol PostCollectionViewCellInterface: AnyObject {
    func setupUI()
    func configure(with post: PostModel)
}

class PostCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PostCollectionViewCell"
    
    private lazy var viewModel: PostCollectionViewModelInterface = PostCollectionViewModel()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
//MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.view = self
        viewModel.overrideinit()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
//MARK: - PostCollectionViewCell Delegate
extension PostCollectionViewCell: PostCollectionViewCellInterface {
    func setupUI() {
        self.clipsToBounds = true
        self.addSubview(imageView)
        self.backgroundColor = .secondarySystemBackground
        }
    // Set thumbnail image for post and configure profile collectionViewCell
    func configure(with post: PostModel) {
        imageView.image = UIImage(named: "dog2")
        }

}
