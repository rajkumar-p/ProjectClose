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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setupTableView()

        setupRealm()
        loadClosedTasks()
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

            self?.reloadTableView()
        })
        deleteAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellDeleteButtonColor)

        let reOpenAction = UITableViewRowAction(style: .normal, title: "Re-Open", handler: { [weak self] action, indexPath in
            try! self?.realm.write {
                closedTask.closed = false
                closedTask.closedDate = nil
            }

            self?.reloadTableView()
        })
        reOpenAction.backgroundColor = UIColor(hexString: ProjectCloseColors.inboxTasksTableViewControllerTableCellReOpenButtonColor)

        return [reOpenAction, deleteAction]
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
