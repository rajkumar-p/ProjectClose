//
//  AllInboxTableViewController.swift
//  ProjectClose
//
//  Created by raj on 19/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class AllInboxTableViewController: UITableViewController {
    let allInboxTableViewCellReuseIdentifier = "AllInboxCell"

    var realm: Realm!
    var taskResultSet: Results<Task>!

    var allTasksNotificationToken: NotificationToken!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        setupRealm()
        loadTasks()
        listenForAllTasksNotifications()
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(InboxTaskTableViewCell.classForCoder(), forCellReuseIdentifier: allInboxTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadTasks() {
        let closedDateSortDescriptor = SortDescriptor(keyPath: "closedDate")
        let createdDateSortDescriptor = SortDescriptor(keyPath: "createdDate", ascending: false)
        taskResultSet = realm.objects(Task.self).sorted(by: [closedDateSortDescriptor, createdDateSortDescriptor])
    }

    func listenForAllTasksNotifications() {
        allTasksNotificationToken = taskResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        allTasksNotificationToken?.stop()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = taskResultSet[indexPath.row]
        let leadForTask = realm.object(ofType: Lead.self, forPrimaryKey: task.leadId)

        let taskCell = tableView.dequeueReusableCell(withIdentifier: allInboxTableViewCellReuseIdentifier, for: indexPath) as! InboxTaskTableViewCell

        taskCell.leadLabel?.text = leadForTask?.shortIdentifier
        taskCell.leadLabel?.textAlignment = .center
        taskCell.leadLabel?.textColor = UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerLeadTitleColor)
        taskCell.leadLabel?.font = UIFont(name: ProjectCloseFonts.allInboxTableViewControllerLeadLabelFont, size: 20.0)

        taskCell.mainLabel?.font = UIFont(name:  ProjectCloseFonts.allInboxTableViewControllerTitleFont, size: 20.0)
        taskCell.mainLabel?.textColor = UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerTitleColor)

        taskCell.subTitleLabel?.textColor = UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerSubtitleColor)

        var subtitleText = task.assignedTo.name
        if let expiryDate = task.expiryDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            subtitleText = subtitleText + " / " + dateFormatter.string(from: expiryDate)
            if task.expiryDeadlineDate < Date() && !task.closed {
                taskCell.subTitleLabel?.textColor = UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerExpiredSubtitleColor)
            } else {
                taskCell.subTitleLabel?.textColor = UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerSubtitleColor)
            }
        }

        taskCell.subTitleLabel?.font = UIFont(name: ProjectCloseFonts.allInboxTableViewControllerSubtitleFont, size: 18.0)

        if task.closed {
            let titleAttributedText = NSAttributedString(string: task.taskDescription, attributes:
            [
                    NSStrikethroughStyleAttributeName : 2,
                    NSStrikethroughColorAttributeName: UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerTableCellTitleStrikeThroughColor)!
            ])
            taskCell.mainLabel?.attributedText = titleAttributedText

            let subtitleAttributedText = NSAttributedString(string: subtitleText, attributes:
            [
                    NSStrikethroughStyleAttributeName : 2,
                    NSStrikethroughColorAttributeName: UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerTableCellSubtitleStrikeThroughColor)!
            ])
            taskCell.subTitleLabel?.attributedText = subtitleAttributedText
        } else {
            taskCell.mainLabel?.text = task.taskDescription
            taskCell.subTitleLabel?.text = subtitleText
        }

        return taskCell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let task = taskResultSet[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: { [weak self] action, indexPath in
            try! self?.realm.write {
                self?.realm.delete(task)
            }
        })
        deleteAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellDeleteButtonColor)

        if task.closed {
            let reOpenAction = UITableViewRowAction(style: .normal, title: "Re-Open", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    task.closed = false
                    task.closedDate = nil
                }
            })
            reOpenAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellReOpenButtonColor)

            return [reOpenAction, deleteAction]
        } else {
            let closeAction = UITableViewRowAction(style: .normal, title: "Close", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    task.closed = true
                    task.closedDate = Date()
                }
            })
            closeAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellCloseButtonColor)

            return [closeAction, deleteAction]
        }

    }

    func reloadTableView() {
        self.tableView?.reloadData()
    }

}
