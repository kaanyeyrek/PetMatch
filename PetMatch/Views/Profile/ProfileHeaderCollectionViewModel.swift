//
//  ProfileHeaderCollectionViewModel.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/14/22.
//
import Foundation

protocol ProfileHeaderCollectionViewModelInterface {
    var view: ProfileHeaderCollectionInterface? { get set }
    func overrideinit()
    func didTapFollowersButton()
    func didTapFollowingButton()
    func didTapPrimaryButton()
}

final class ProfileHeaderCollectionViewModel {
    weak var view: ProfileHeaderCollectionInterface?
    var model : ProfileHeaderModel?
}

extension ProfileHeaderCollectionViewModel: ProfileHeaderCollectionViewModelInterface {
  
    func overrideinit() {
        view?.setupUI()
        view?.layout()
        
    }
    func didTapFollowersButton() {
        print("tapped followers")
    }
    
    func didTapFollowingButton() {
        print("tapped following")
    }
    
    func didTapPrimaryButton() {
        print("tapped primary")
    }
    
   
}
