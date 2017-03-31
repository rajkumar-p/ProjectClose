//
//  LeadTasksTableViewController.swift
//  ProjectClose
//
//  Created by raj on 23/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class LeadTasksTableViewController: UITableViewController, AddLeadTaskDelegate {
    let leadTaskTableViewCellReuseIdentifier = "LeadTaskCell"
    var leadId: String!

    var realm: Realm!
    var leadTasksResultSet: Results<Task>!

    var leadTasksNotificationToken: NotificationToken!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        setupRealm()
        loadLeadTasks()
        listenForLeadTasksNotifications()
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLeadTasks() {
        let closedDateSortDescriptor = SortDescriptor(keyPath: "closedDate")
        let createdDateSortDescriptor = SortDescriptor(keyPath: "createdDate", ascending: false)
        leadTasksResultSet = realm.objects(Task.self).filter(NSPredicate(format: "leadId == %@", leadId)).sorted(by: [closedDateSortDescriptor, createdDateSortDescriptor])
    }

    func listenForLeadTasksNotifications() {
        leadTasksNotificationToken = leadTasksResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
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
        print("Memory warning : LeadTasksTableViewController")
    }

    deinit {
        leadTasksNotificationToken.stop()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leadTasksResultSet.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leadTask = leadTasksResultSet[indexPath.row]

        var leadTaskCell = tableView.dequeueReusableCell(withIdentifier: leadTaskTableViewCellReuseIdentifier)

        if leadTaskCell == nil {
            leadTaskCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadTaskTableViewCellReuseIdentifier)
        }
        
        leadTaskCell?.textLabel?.font = UIFont(name:  ProjectCloseFonts.leadTasksTableViewControllerTitleFont, size: 20.0)
        leadTaskCell?.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTitleColor)
        
        leadTaskCell?.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerSubtitleColor)

        var subtitleText = leadTask.assignedTo.name
        if let expiryDate = leadTask.expiryDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            subtitleText = subtitleText + " / " + dateFormatter.string(from: expiryDate)
            if leadTask.expiryDeadlineDate < Date() && !leadTask.closed {
                leadTaskCell?.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerExpiredSubtitleColor)
            } else {
                leadTaskCell?.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerSubtitleColor)
            }
        }
        
        leadTaskCell?.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.leadsTableViewControllerStatus, size: 18.0)
        
        if leadTask.closed {
            let titleAttributedText = NSAttributedString(string: leadTask.taskDescription, attributes:
            [
                NSStrikethroughStyleAttributeName : 2,
                NSStrikethroughColorAttributeName: UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTableCellTitleStrikeThroughColor)!
            ])
            leadTaskCell?.textLabel?.attributedText = titleAttributedText
            
            let subtitleAttributedText = NSAttributedString(string: subtitleText, attributes:
            [
                    NSStrikethroughStyleAttributeName : 2,
                    NSStrikethroughColorAttributeName: UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTableCellSubtitleStrikeThroughColor)!
            ])
            leadTaskCell?.detailTextLabel?.attributedText = subtitleAttributedText
        } else {
            leadTaskCell?.textLabel?.text = leadTask.taskDescription
            leadTaskCell?.detailTextLabel?.text = subtitleText
        }

        return leadTaskCell!
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let leadTask = leadTasksResultSet[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: { [weak self] action, indexPath in
            try! self?.realm.write {
                self?.realm.delete(leadTask)
            }
        })
        deleteAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTableCellDeleteButtonColor)

        if leadTask.closed {
            let reOpenAction = UITableViewRowAction(style: .normal, title: "Re-Open", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    leadTask.closed = false
                    leadTask.closedDate = nil
                }
            })
            reOpenAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTableCellReOpenButtonColor)

            return [reOpenAction, deleteAction]
        } else {
            let closeAction = UITableViewRowAction(style: .normal, title: "Close", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    leadTask.closed = true
                    leadTask.closedDate = Date()
                }
            })
            closeAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTableCellCloseButtonColor)

            return [closeAction, deleteAction]
        }

    }

    func didFinishAddingLeadTask(sender: AddLeadTaskViewController) {
    }

    func reloadTableView() {
        self.tableView?.reloadData()
    }

}
