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
//        setupAddTaskButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setupTableView()

        setupRealm()
        loadLeadTasks()
        listenForLeadTasksNotifications()
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: leadTaskTableViewCellReuseIdentifier)
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
        leadTasksResultSet = realm.objects(Task.self).sorted(by: [closedDateSortDescriptor, createdDateSortDescriptor])
    }

    func listenForLeadTasksNotifications() {
        leadTasksNotificationToken = leadTasksResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                print("Initial - LeadTasksTableViewController")
                self?.reloadTableView()
                break
            case .update(_, let deletions, let insertions, let modifications):
                print("Update - LeadTasksTableViewController")
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leadTasksResultSet.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leadTask = leadTasksResultSet[indexPath.row]

        let leadTaskCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadTaskTableViewCellReuseIdentifier)
        
        leadTaskCell.textLabel?.font = UIFont(name:  ProjectCloseFonts.leadTasksTableViewControllerTitleFont, size: 20.0)
        leadTaskCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTitleColor)
        
        leadTaskCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerSubtitleColor)

        var subtitleText = leadTask.assignedTo.name
        if let expiryDate = leadTask.expiryDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            subtitleText = subtitleText + " / " + dateFormatter.string(from: expiryDate)
            if leadTask.expiryDeadlineDate < Date() {
                leadTaskCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerExpiredSubtitleColor)
            } else {
                leadTaskCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerSubtitleColor)
            }
//            let order = NSCalendar.current.compare(Date(), to: expiryDate, toGranularity: .day)
//            switch order {
//            case .orderedAscending:
//                leadTaskCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerSubtitleColor)
//            case .orderedDescending:
//                leadTaskCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerExpiredSubtitleColor)
//            case .orderedSame:
//                leadTaskCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerSubtitleColor)
//            }
        }
        
        leadTaskCell.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.leadsTableViewControllerStatus, size: 18.0)
        
        if leadTask.closed {
            let titleAttributedText = NSAttributedString(string: leadTask.taskDescription, attributes:
            [
                NSStrikethroughStyleAttributeName : 2,
                NSStrikethroughColorAttributeName: UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTableCellTitleStrikeThroughColor)!
            ])
            leadTaskCell.textLabel?.attributedText = titleAttributedText
            
            let subtitleAttributedText = NSAttributedString(string: subtitleText, attributes:
            [
                    NSStrikethroughStyleAttributeName : 2,
                    NSStrikethroughColorAttributeName: UIColor(hexString: ProjectCloseColors.leadTasksTableViewControllerTableCellSubtitleStrikeThroughColor)!
            ])
            leadTaskCell.detailTextLabel?.attributedText = subtitleAttributedText
        } else {
            leadTaskCell.textLabel?.text = leadTask.taskDescription
            leadTaskCell.detailTextLabel?.text = subtitleText
        }

        return leadTaskCell
    }

//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        return .delete
//    }
//
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        tableView!.setEditing(editing, animated: animated)
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let leadTask = leadTasksResultSet[indexPath.row]
//            try! realm.write {
//                realm.delete(leadTask)
//            }
//
//            tableView.deleteRows(at: [indexPath], with: .left)
//        }
//    }

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
//
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        
//    }

    func didFinishAddingLeadTask(sender: AddLeadTaskViewController) {
//        reloadTableView()
        print("didFinishAddingLeadTask from LeadTasksTableViewController.")
    }

    func reloadTableView() {
        self.tableView?.reloadData()
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
