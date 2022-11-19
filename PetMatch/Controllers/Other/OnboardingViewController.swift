//
//  OnboardingViewController.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/15/22.
//

import UIKit
protocol OnboardingViewInterface: AnyObject {
    func setupUI()
    func tabBarConfig()
    func scrollViewConfig()
    func configureOnboarding()
}

class OnboardingViewController: UIViewController {
    private let holderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    lazy var viewModel: OnboardingViewModelInterface = OnboardingViewModel()
// MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
//MARK: - Action
    @objc func didTapNextButton(_ button: UIButton) {
        guard button.tag < 3 else {
            AuthManager.shared.setIsNotNewUser()
            navigationController?.popToRootViewController(animated: true)
            return
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
   
    
}
// MARK: - OnBoardingView Delegate
extension OnboardingViewController: OnboardingViewInterface {
    func setupUI() {
        view.clipsToBounds = true
        view.addSubview(holderView)
    }

    func tabBarConfig() {
        tabBarController?.tabBar.layer.cornerRadius = 8
    }
    func configureOnboarding() {
        holderView.frame = view.bounds
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        let titles = ["Welcome!", "Pet Match", "Lets go!"]
        for x in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * (holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)

            let label = UILabel(frame: CGRect(x: 10, y: 50, width: pageView.frame.size.width - 20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10 + 120 + 10, width: pageView.frame.width - 20, height: pageView.frame.size.height - 60 - 130 - 15))
            let nextButton = UIButton(frame: CGRect(x: 80, y: pageView.frame.size.height - 180, width: pageView.frame.width - 160, height: 50))
            
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 32)
            pageView.addSubview(label)
            label.text = titles[x]

           
            imageView.image = UIImage(named: "onboarding_\(x+1)")
            imageView.contentMode = .scaleAspectFit
            pageView.addSubview(imageView)
            
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.backgroundColor = .black
            nextButton.setTitle("Continue", for: .normal)
            nextButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
            nextButton.layer.cornerRadius = 25
            nextButton.layer.masksToBounds = true
            nextButton.isUserInteractionEnabled = true
    
            if x == 2 {
                nextButton.setTitle("Get Started", for: .normal)
            }
            nextButton.tag = x+1
         
            nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
            pageView.addSubview(nextButton)
        }
    }
    
    func scrollViewConfig() {
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*3, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    

}
