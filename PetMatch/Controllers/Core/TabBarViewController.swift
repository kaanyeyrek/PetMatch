//
//  TabBarViewController.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/3/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }

    private func setupVC() {
        let home = HomeViewController()
        let notifications = NotificationsViewController()
        let messages = MessagesViewController()
        let profile = ProfileViewController()

        home.title = "Home"
        notifications.title = "Notifications"
        messages.title = "Messages"
        profile.title = "Profile"

        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: notifications)
        let nav3 = UINavigationController(rootViewController: messages)
        let nav4 = UINavigationController(rootViewController: profile)

        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "ellipsis.message"), tag: 2)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle"), tag: 3)

        nav1.navigationBar.backgroundColor = .clear
        nav1.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav1.navigationBar.shadowImage = UIImage()

//        nav1.navigationItem.backButtonDisplayMode = .minimal
//        nav2.navigationItem.backButtonDisplayMode = .minimal
//        nav3.navigationItem.backButtonDisplayMode = .minimal
//        nav4.navigationItem.backButtonDisplayMode = .minimal
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }
}
