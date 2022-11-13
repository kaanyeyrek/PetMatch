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
    var numbersOfRowsInSection: Int { get }
    var heightForRowAt: CGFloat { get }
  
}
final class NotificationsViewModel {
    weak var view: NotificationsInterface?
    var notification: [Notification] = [Notification]()
    private var shouldNeedToCallPulledDownRefreshControl = true
   


     func fetchNotifications() {
         view?.beginRefreshing()
         DatabaseManager.shared.getNotifications { [weak self] notifications in
             self?.notification = notifications
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
        guard let isDraggin = view?.isDragging, !isDraggin else {
            shouldNeedToCallPulledDownRefreshControl = true
            return
        }
        fetchNotifications()
    }

    func didSelectItemAt(at indexPath: IndexPath) {
        print("tapped")
    }
    func commitEditingStyle(at indexPath: IndexPath) {
        notification.remove(at: indexPath.row)
    }
    var numbersOfRowsInSection: Int { notification.count }
    var heightForRowAt: CGFloat { 70 }
}





    
    

