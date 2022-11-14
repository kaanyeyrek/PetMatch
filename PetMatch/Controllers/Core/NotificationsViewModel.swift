//
//  NotificationsViewModel.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/12/22.
//

import Foundation

protocol NotificationsViewModelInterface {
    var view: NotificationsInterface? { get set }
    func viewDidLoad()
    func viewWillAppear()
    func didTapRefresh()
    func didSelectItemAt(at indexPath: IndexPath)
    func commitEditingStyle(at indexPath: IndexPath)
    func getNotifications(at indexPath: IndexPath) -> Notifications
    var numbersOfRowsInSection: Int { get }
    var heightForRowAt: CGFloat { get }
}

final class NotificationsViewModel {
    weak var view: NotificationsInterface?
    var notifications: [Notifications] = []
    
    func fetchNotifications() {
        view?.beginRefreshing()
        DatabaseManager.shared.getNotifications { [weak self] notifications in
            self?.notifications = notifications
            self?.view?.reloadData()
            self?.view?.endRefreshing()
        }
    }
}

extension NotificationsViewModel: NotificationsViewModelInterface {
    func viewDidLoad() {
        view?.setupUI()
        view?.prepareTableView()
        view?.setupLayout()
        fetchNotifications()
    }

    func viewWillAppear() {
        view?.prepareRefreshControl(with: .label)
    }

    func didTapRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.fetchNotifications()
        }
    }

    func didSelectItemAt(at indexPath: IndexPath) {
        print("tapped index")
    }

    func commitEditingStyle(at indexPath: IndexPath) {
        notifications.remove(at: indexPath.row)
    }

    var numbersOfRowsInSection: Int { notifications.count }
    var heightForRowAt: CGFloat { 70 }
    func getNotifications(at indexPath: IndexPath) -> Notifications {
        return notifications[indexPath.row]
    }
}

    

