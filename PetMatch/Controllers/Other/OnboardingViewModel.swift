//
//  OnboardingViewModel.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/16/22.
//

import Foundation

protocol OnboardingViewModelInterface {
    var view: OnboardingViewInterface? { get set }
    func viewWillAppear()
    func viewDidLoad()
    func scrollViewConfig()
    func tabBarConfig()
}

final class OnboardingViewModel {
    weak var view: OnboardingViewInterface?
    
}
//MARK: - OnBoardingViewModel Delegate
extension OnboardingViewModel: OnboardingViewModelInterface {
    func viewWillAppear() {
        view?.configureOnboarding()
    }
    func viewDidLoad() {
        view?.setupUI()
    }
    func tabBarConfig() {
        view?.tabBarConfig()
    }
    func scrollViewConfig() {
        view?.scrollViewConfig()
    }
}
