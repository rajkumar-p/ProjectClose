//
//  LeadsTableViewController.swift
//  ProjectClose
//
//  Created by raj on 20/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift
import PagingMenuController

class LeadsTableViewController: UITableViewController, AddLeadDelegate, ChangeLeadDelegate {
    let leadTableViewCellReuseIdentifier = "leadCell"

    var realm: Realm!
    var leadsResultSet: Results<Lead>!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        initTitle()
        
        setupRealm()
        loadLeads()
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

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLeads() {
        leadsResultSet = realm.objects(Lead.self)
    }

    func addLeadButtonPressed(_ sender: UIBarButtonItem) {
        let addLeadViewController = AddLeadViewController()
        addLeadViewController.addDelegate = self
        addLeadViewController.changeDelegate = self

        self.navigationController?.pushViewController(addLeadViewController, animated: true)
    }

    func setupAddLeadButton() {
        let addLeadBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(LeadsTableViewController.addLeadButtonPressed(_:)))
        addLeadBarButton.tintColor = UIColor(hexString: ProjectCloseColors.leadsTableViewControllerAddLeadButtonColor)

        self.navigationItem.rightBarButtonItem = addLeadBarButton
    }

    func reloadTableView() {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning : LeadsTableViewController")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leadsResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lead = leadsResultSet[indexPath.row]

        let companyName = lead.companyName
        let status = lead.status
        
        let leadCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadTableViewCellReuseIdentifier)
        leadCell.textLabel?.text = companyName
        leadCell.textLabel?.font = UIFont(name: ProjectCloseFonts.leadsTableViewControllerCompanyName, size: 20.0)
        leadCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadsTableViewControllerCompanyNameColor)

        leadCell.detailTextLabel?.text = status
        leadCell.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.leadsTableViewControllerStatus, size: 18.0)
        leadCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadsTableViewControllerStatusColor)

        return leadCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLead = leadsResultSet[indexPath.row]
        
//        let leadDetailsPagingMenuViewController: LeadDetailsPagingMenuViewController = makeLeadDetailsPagingViewController(leadId: selectedLead.leadId, mainNavigationController: self.navigationController!)
//        leadDetailsPagingMenuViewController.changeDelegate = self
//        //        self.present(leadDetailsPagingMenuViewController, animated: true)
////        self.navigationController?.addChildViewController(leadDetailsPagingMenuViewController)
////        self.navigationController?.view.addSubview(leadDetailsPagingMenuViewController.view)
////        leadDetailsPagingMenuViewController.didMove(toParentViewController: self)
//        self.navigationController?.pushViewController(leadDetailsPagingMenuViewController, animated: true)

        let leadDetailsContainerViewController = LeadDetailsContainerViewController(leadId: selectedLead.leadId)
        leadDetailsContainerViewController.changeDelegate = self

        let leadDetailsPagingMenuViewController = makeLeadDetailsPagingViewController(leadId: selectedLead.leadId)

        leadDetailsContainerViewController.addChildViewController(leadDetailsPagingMenuViewController)
        leadDetailsContainerViewController.view.addSubview(leadDetailsPagingMenuViewController.view)

        leadDetailsPagingMenuViewController.didMove(toParentViewController: self)

        self.navigationController?.pushViewController(leadDetailsContainerViewController, animated: true)
    }

    func didFinishAddingLead(sender: AddLeadViewController) {
        reloadTableView()
    }

    func didChangeLead(sender: LeadDetailsContainerViewController) {
        reloadTableView()
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
