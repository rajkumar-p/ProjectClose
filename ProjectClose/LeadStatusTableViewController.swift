//
//  LeadStatusTableViewController.swift
//  ProjectClose
//
//  Created by raj on 23/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class LeadStatusTableViewController: UITableViewController {
    let leadStatusTableViewCellReuseIdentifier = "LeadStatusCell"
    let leadDataSource = ["Potential", "Bad Fit", "Qualified", "Customer"]

    var realm: Realm!
    var leadId: String!
    var lead: Lead!

    var selectedIndexPath: IndexPath!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(leadId: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.leadId = leadId
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
        loadLead()
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: leadStatusTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLead() {
        lead = realm.object(ofType: Lead.self, forPrimaryKey: leadId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LeadStatusTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leadDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leadStatusCell = UITableViewCell(style: .default, reuseIdentifier: leadStatusTableViewCellReuseIdentifier)
        leadStatusCell.selectionStyle = .none
        leadStatusCell.tintColor = UIColor(hexString: ProjectCloseColors.leadStatusTableViewControllerTableViewCellTintColor)

        leadStatusCell.textLabel?.text = leadDataSource[indexPath.row]
        leadStatusCell.textLabel?.font = UIFont(name: ProjectCloseFonts.leadStatusTableViewControllerTitleFont, size: 20.0)

        if leadDataSource[indexPath.row] == lead.status {
            selectedIndexPath = indexPath
            leadStatusCell.accessoryType = .checkmark
            leadStatusCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadStatusTableViewControllerSelectedTitleColor)
        } else {
            leadStatusCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadStatusTableViewControllerTitleColor)
        }

        return leadStatusCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousSelectedCell = self.tableView?.cellForRow(at: selectedIndexPath)
        previousSelectedCell?.accessoryType = .none
        previousSelectedCell?.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadStatusTableViewControllerTitleColor)
        
        let currentSelectedCell = self.tableView?.cellForRow(at: indexPath)
        currentSelectedCell?.accessoryType = .checkmark
        currentSelectedCell?.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadStatusTableViewControllerSelectedTitleColor)
        
        selectedIndexPath = indexPath

        try! realm.write {
            lead.status = leadDataSource[indexPath.row]
        }

        reloadTableViewData()
    }

    func reloadTableViewData() {
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
