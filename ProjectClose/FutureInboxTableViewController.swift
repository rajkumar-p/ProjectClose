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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setupTableView()

        setupRealm()
        loadFutureTasks()
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
//        futureTasksResultSet = realm.objects(Task.self).filter { self.isTaskExpired(expiryDate: $0.expiryDate) == false }
        futureTasksResultSet = realm.objects(Task.self).filter(NSPredicate(format: "expiryDate != nil AND %@ < Calendar.current.date(byAdding: .day, value: 1, to: expiryDate)", argumentArray: [Date()]))
//        futureTasksResultSet = realm.objects(Task.self).filter("expiryDate != nil").sorted(byProperty: "expiryDate", ascending: true)
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

            self?.reloadTableView()
        })
        deleteAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellDeleteButtonColor)

        if futureTask.closed {
            let reOpenAction = UITableViewRowAction(style: .normal, title: "Re-Open", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    futureTask.closed = false
                    futureTask.closedDate = nil
                }

                self?.reloadTableView()
            })
            reOpenAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellReOpenButtonColor)

            return [reOpenAction, deleteAction]
        } else {
            let closeAction = UITableViewRowAction(style: .normal, title: "Close", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    futureTask.closed = true
                    futureTask.closedDate = Date()
                }

                self?.reloadTableView()
            })
            closeAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellCloseButtonColor)

            return [closeAction, deleteAction]
        }

    }

    func reloadTableView() {
        self.tableView?.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
