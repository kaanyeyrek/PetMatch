//
//  NotificationsViewController.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/3/22.
//

import UIKit

class NotificationsViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(NotificationsUserTableViewCell.self, forCellReuseIdentifier: NotificationsUserTableViewCell.identifier)
        table.register(NotificationsPostLikeTableViewCell.self, forCellReuseIdentifier: NotificationsPostLikeTableViewCell.identifier)
        table.register(NotificationsCommentTableViewCell.self, forCellReuseIdentifier: NotificationsCommentTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private var notifications = [Notification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        setupSubview()
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
        fetchNotifications()

        let control = UIRefreshControl()
        tableView.refreshControl = control
        control.addTarget(self, action: #selector(didTapRefresh(_:)), for: .valueChanged)
    }
// tableView refresh for data
    @objc private func didTapRefresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        DatabaseManager.shared.getNotifications { [weak self] notifications in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.notifications = notifications
                self?.tableView.reloadData()
                sender.endRefreshing()
            }
        }
    }
// Subview
    private func setupSubview() {
        view.addSubview(tableView)
    }

// Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),

        ])
    }
// DatabaseManager completion fetchNotifications
    private func fetchNotifications() {
        DatabaseManager.shared.getNotifications { [weak self] notifications in
            DispatchQueue.main.async {
                self?.notifications = notifications
                self?.tableView.reloadData()
            }
        }
    }

}
// TableView Methods
extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
// Notifications Custom Cell
// -> .userFollow, .postLike, .postComment
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = notifications[indexPath.row]
        switch model.type {
        case let .userFollow(username: userName):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsUserTableViewCell.identifier, for: indexPath) as? NotificationsUserTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: userName, model: model)
            return cell

        case let .postLike(postName: postName):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsPostLikeTableViewCell.identifier, for: indexPath) as? NotificationsPostLikeTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: postName, model: model)
            return cell

        case let .postComment(postName: postName):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsCommentTableViewCell.identifier, for: indexPath) as?
                NotificationsCommentTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: postName, model: model)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
// Delete methods
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        notifications.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
}

