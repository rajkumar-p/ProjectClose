//
//  UsersTableViewController.swift
//  ProjectClose
//
//  Created by raj on 16/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class UsersTableViewController: UITableViewController, AddUserDelegate {
    private var realm: Realm!
    private var usersResultSet: Results<User>!

    var usersNotificationToken: NotificationToken!

    private let userTableViewCellReuseIdentifier = "UserCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        initTitle()
        setupView()
        setupTableView()
        setupLeftBarButton()
        setupAddUserButton()

        setupRealm()
        getAllUsers()
        listenForUsersNotifications()
    }

    func initTitle() {
        self.title = NSLocalizedString("users_vc_title", value: "Users", comment: "Users VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(UsersTableViewController.backButtonPressed(_:)))
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func getAllUsers() {
        usersResultSet = realm.objects(User.self)
    }

    func listenForUsersNotifications() {
        usersNotificationToken = usersResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.reloadTableView()
                break
            case .update(_, let deletions, let insertions, let modifications):
                self?.tableView.beginUpdates()
                self?.tableView.insertRows(at: insertions.map { IndexPath(item: $0, section: 0) }, with: .automatic)
                self?.tableView.deleteRows(at: deletions.map { IndexPath(item: $0, section: 0) }, with: .automatic)
                self?.tableView.reloadRows(at: modifications.map { IndexPath(item: $0, section: 0) }, with: .automatic)
                self?.tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }

    func backButtonPressed(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func setupAddUserButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(UsersTableViewController.addUserButtonPressed(_:)))
        rightBarButtonItem.tintColor = UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerAddTaskButtonColor)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func addUserButtonPressed(_ sender: UIBarButtonItem) {
        let addUserViewController = AddUserViewController()
        addUserViewController.delegate = self

        self.navigationController?.pushViewController(addUserViewController, animated: true)
    }

    func didFinishAddingUser(sender: AddUserViewController) {
//        self.tableView.reloadData()
    }

    deinit {
        usersNotificationToken.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : UsersTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = usersResultSet[indexPath.row]
        
        let name = user.name
        let email = user.email

        var userCell = tableView.dequeueReusableCell(withIdentifier: userTableViewCellReuseIdentifier)

        if userCell == nil {
            userCell = UITableViewCell(style: .subtitle, reuseIdentifier: userTableViewCellReuseIdentifier)
        }

        userCell?.textLabel?.text = name
        userCell?.textLabel?.font = UIFont(name: ProjectCloseFonts.usersTableViewControllerNameFont, size: 20.0)
        userCell?.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.usersTableViewControllerNameColor)

        userCell?.detailTextLabel?.text = email
        userCell?.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.usersTableViewControllerEmailFont, size: 18.0)
        userCell?.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.usersTableViewControllerEmailColor)

        return userCell!
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView!.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = usersResultSet[indexPath.row]
            try! realm.write {
                realm.delete(user)
            }

            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    func reloadTableView() {
        self.tableView?.reloadData()
    }

}
