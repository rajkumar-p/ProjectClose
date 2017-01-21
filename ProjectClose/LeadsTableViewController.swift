//
//  LeadsTableViewController.swift
//  ProjectClose
//
//  Created by raj on 20/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class LeadsTableViewController: UITableViewController {
    let leadTableViewCellReuseIdentifier = "leadCell"

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        initTitle()
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
        setupView()
        setupTableView()
        setupAddLeadButton()
    }

    func initTitle() {
        self.title = NSLocalizedString("leads_table_vc_title", value: "Leads", comment: "Leads Table VC title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: leadTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func addLeadButtonPressed(_ sender: UIBarButtonItem) {
        let addLeadViewController = AddLeadViewController()
        self.navigationController?.pushViewController(addLeadViewController, animated: true)
    }

    func setupAddLeadButton() {
        let addLeadBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(LeadsTableViewController.addLeadButtonPressed(_:)))
        addLeadBarButton.tintColor = UIColor(hexString: ProjectCloseColors.leadsTableViewControllerAddLeadButtonColor)

        self.navigationItem.rightBarButtonItem = addLeadBarButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning : LeadsTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
