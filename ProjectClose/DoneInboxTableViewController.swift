//
//  DoneInboxTableViewController.swift
//  ProjectClose
//
//  Created by raj on 19/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class DoneInboxTableViewController: UITableViewController {
    let doneInboxTableViewCellReuseIdentifier = "DoneInboxCell"

    var realm: Realm!
    var closedTasksResultSet: Results<Task>!

    var closedTasksNotificationToken: NotificationToken!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        setupRealm()
        loadClosedTasks()
        listenForClosedTasksNotifications()
    }
    
    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(InboxTaskTableViewCell.classForCoder(), forCellReuseIdentifier: doneInboxTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadClosedTasks() {
        closedTasksResultSet = realm.objects(Task.self).filter(NSPredicate(format: "closed == %@", NSNumber(booleanLiteral: true)))
    }

    func listenForClosedTasksNotifications() {
        closedTasksNotificationToken = closedTasksResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
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
        closedTasksNotificationToken.stop()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return closedTasksResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let closedTask = closedTasksResultSet[indexPath.row]
        let leadForTask = realm.object(ofType: Lead.self, forPrimaryKey: closedTask.leadId)

        let closedTaskCell = tableView.dequeueReusableCell(withIdentifier: doneInboxTableViewCellReuseIdentifier, for: indexPath) as! InboxTaskTableViewCell

        closedTaskCell.leadLabel?.text = leadForTask?.shortIdentifier
        closedTaskCell.leadLabel?.textAlignment = .center
        closedTaskCell.leadLabel?.textColor = UIColor(hexString: ProjectCloseColors.doneInboxTableViewControllerLeadTitleColor)
        closedTaskCell.leadLabel?.font = UIFont(name: ProjectCloseFonts.doneInboxTableviewcontrollerLeadlabelfont, size: 20.0)

        let titleAttributedText = NSAttributedString(string: closedTask.taskDescription, attributes:
        [
                NSStrikethroughStyleAttributeName : 2,
                NSStrikethroughColorAttributeName: UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerTableCellTitleStrikeThroughColor)!
        ])
        closedTaskCell.mainLabel?.attributedText = titleAttributedText
        closedTaskCell.mainLabel?.font = UIFont(name: ProjectCloseFonts.doneInboxTableviewcontrollerTitlefont, size: 20.0)
        closedTaskCell.mainLabel?.textColor = UIColor(hexString: ProjectCloseColors.doneInboxTableViewControllerTitleColor)

        var subtitleText = closedTask.assignedTo.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        if let expiryDate = closedTask.expiryDate {
            subtitleText = subtitleText + " / " + dateFormatter.string(from: expiryDate)
        }

        closedTaskCell.subTitleLabel?.textColor = UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerSubtitleColor)
        closedTaskCell.subTitleLabel?.font = UIFont(name: ProjectCloseFonts.allInboxTableViewControllerSubtitleFont, size: 18.0)

        let subtitleAttributedText = NSAttributedString(string: subtitleText, attributes:
        [
                NSStrikethroughStyleAttributeName : 2,
                NSStrikethroughColorAttributeName: UIColor(hexString: ProjectCloseColors.allInboxTableViewControllerTableCellSubtitleStrikeThroughColor)!
        ])

        closedTaskCell.subTitleLabel?.attributedText = subtitleAttributedText
        closedTaskCell.subTitleLabel?.font = UIFont(name: ProjectCloseFonts.doneInboxTableviewcontrollerSubtitlefont, size: 18.0)

        return closedTaskCell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let closedTask = closedTasksResultSet[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: { [weak self] action, indexPath in
            try! self?.realm.write {
                self?.realm.delete(closedTask)
            }
        })
        deleteAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellDeleteButtonColor)

        let reOpenAction = UITableViewRowAction(style: .normal, title: "Re-Open", handler: { [weak self] action, indexPath in
            try! self?.realm.write {
                closedTask.closed = false
                closedTask.closedDate = nil
            }
        })
        reOpenAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellReOpenButtonColor)

        return [reOpenAction, deleteAction]
    }

    func reloadTableView() {
        self.tableView?.reloadData()
    }

}
