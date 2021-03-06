//
//  FutureInboxTableViewController.swift
//  ProjectClose
//
//  Created by raj on 19/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class FutureInboxTableViewController: UITableViewController {
    let futureInboxTableViewCellReuseIdentifier = "FutureInboxCell"

    var realm: Realm!
    var futureTasksResultSet: Results<Task>!

    var futureTasksNotificationToken: NotificationToken!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        setupRealm()
        loadFutureTasks()
        listenForFutureTasksNotifications()
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(InboxTaskTableViewCell.classForCoder(), forCellReuseIdentifier: futureInboxTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadFutureTasks() {
        futureTasksResultSet = realm.objects(Task.self).filter(NSPredicate(format: "closed == false AND expiryDate != nil AND %@ < expiryDeadlineDate", argumentArray: [Date()]))
    }

    func listenForFutureTasksNotifications() {
        futureTasksNotificationToken = futureTasksResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
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

    func isTaskExpired(expiryDate: Date!) -> Bool {
        guard (expiryDate != nil) else { return true }
        let order = NSCalendar.current.compare(Date(), to: expiryDate, toGranularity: .day)
        switch order {
        case .orderedAscending:
            return false
        case .orderedDescending:
            return true
        case .orderedSame:
            return false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        futureTasksNotificationToken.stop()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return futureTasksResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let futureTask = futureTasksResultSet[indexPath.row]
        let leadForTask = realm.object(ofType: Lead.self, forPrimaryKey: futureTask.leadId)

        let futureTaskCell = tableView.dequeueReusableCell(withIdentifier: futureInboxTableViewCellReuseIdentifier, for: indexPath) as! InboxTaskTableViewCell

        futureTaskCell.leadLabel?.text = leadForTask?.shortIdentifier
        futureTaskCell.leadLabel?.textAlignment = .center
        futureTaskCell.leadLabel?.textColor = UIColor(hexString: ProjectCloseColors.futureInboxTableViewControllerLeadTitleColor)
        futureTaskCell.leadLabel?.font = UIFont(name: ProjectCloseFonts.futureInboxTableviewcontrollerLeadlabelfont, size: 20.0)

        futureTaskCell.mainLabel?.font = UIFont(name:  ProjectCloseFonts.futureInboxTableviewcontrollerTitlefont, size: 20.0)
        futureTaskCell.mainLabel?.textColor = UIColor(hexString: ProjectCloseColors.futureInboxTableViewControllerTitleColor)

        var subtitleText = futureTask.assignedTo.name
        if let expiryDate = futureTask.expiryDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            subtitleText = subtitleText + " / " + dateFormatter.string(from: expiryDate)

            futureTaskCell.subTitleLabel?.textColor = UIColor(hexString: ProjectCloseColors.futureInboxTableViewControllerSubtitleColor)
            futureTaskCell.subTitleLabel?.font = UIFont(name: ProjectCloseFonts.allInboxTableViewControllerSubtitleFont, size: 18.0)
        }

        futureTaskCell.mainLabel?.text = futureTask.taskDescription
        futureTaskCell.subTitleLabel?.text = subtitleText

        return futureTaskCell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let futureTask = futureTasksResultSet[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: { [weak self] action, indexPath in
            try! self?.realm.write {
                self?.realm.delete(futureTask)
            }
        })
        deleteAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellDeleteButtonColor)

        if futureTask.closed {
            let reOpenAction = UITableViewRowAction(style: .normal, title: "Re-Open", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    futureTask.closed = false
                    futureTask.closedDate = nil
                }
            })
            reOpenAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellReOpenButtonColor)

            return [reOpenAction, deleteAction]
        } else {
            let closeAction = UITableViewRowAction(style: .normal, title: "Close", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    futureTask.closed = true
                    futureTask.closedDate = Date()
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
