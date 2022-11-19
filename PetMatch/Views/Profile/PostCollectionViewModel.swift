//
//  PostCollectionViewModel.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/14/22.
//

import Foundation
protocol PostCollectionViewModelInterface {
    var view: PostCollectionViewCellInterface? { get set }
    func overrideinit()
}

final class PostCollectionViewModel: PostCollectionViewModelInterface {
    weak var view: PostCollectionViewCellInterface?
    
    func overrideinit() {
        view?.setupUI()
    }
}
