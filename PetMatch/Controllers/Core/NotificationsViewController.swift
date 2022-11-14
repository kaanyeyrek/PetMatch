//
//  NotificationsViewController.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/3/22.
//

import UIKit

protocol NotificationsInterface: AnyObject {
    func prepareTableView()
    func setupUI()
    func setupLayout()
    func prepareRefreshControl(with color: UIColor)
    func beginRefreshing()
    func endRefreshing()
    func reloadData()
}

class NotificationsViewController: UIViewController {
    public let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var viewModel: NotificationsViewModelInterface = NotificationsViewModel()

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
//MARK: - Actions
    // tableView refresh for data
    @objc private func didTapRefresh(_ sender: UIRefreshControl) {
        viewModel.didTapRefresh()
    }
}

// MARK: - TableView Methods

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfRowsInSection
    }

    // Notifications Custom Cell
    // -> .userFollow, .postLike, .postComment
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.getNotifications(at: indexPath)
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
        viewModel.heightForRowAt
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItemAt(at: indexPath)
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
        viewModel.commitEditingStyle(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
}
//MARK: -  NotificationsInterface Delegate
extension NotificationsViewController: NotificationsInterface {
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(NotificationsUserTableViewCell.self, forCellReuseIdentifier: NotificationsUserTableViewCell.identifier)
        tableView.register(NotificationsPostLikeTableViewCell.self, forCellReuseIdentifier: NotificationsPostLikeTableViewCell.identifier)
        tableView.register(NotificationsCommentTableViewCell.self, forCellReuseIdentifier: NotificationsCommentTableViewCell.identifier)
        tableView.reloadData()

    }
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
// Refresh
    func prepareRefreshControl(with color: UIColor) {
        let control = UIRefreshControl()
        control.tintColor = color
        tableView.refreshControl = control
        control.addTarget(self, action: #selector(didTapRefresh(_:)), for: .valueChanged)
    }

    func beginRefreshing() {
        tableView.refreshControl?.beginRefreshing()
    }

    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }

    func reloadData() {
        tableView.reloadData()
    }

    
}

