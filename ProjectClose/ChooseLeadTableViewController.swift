//
//  ChooseLeadTableViewController.swift
//  ProjectClose
//
//  Created by raj on 22/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class ChooseLeadTableViewController: UITableViewController {
    let leadTableViewCellReuseIdentifier = "LeadCell"

    var realm: Realm!
    var leadsResultSet: Results<Lead>!

    var previousSelectedLead: Lead!
    var currentSelectedIndexPath: IndexPath!

    var selectedLead: Lead!
    var leadChoosenDelegate: LeadChoosenDelegate!

    init(lead: Lead) {
        super.init(nibName: nil, bundle: nil)
        previousSelectedLead = lead
        selectedLead = previousSelectedLead
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
        initTitle()
        setupView()
        setupTableView()

        setupLeftBarButton()
        setupRealm()
        loadLeads()
    }

    func initTitle() {
        self.title = NSLocalizedString("choose_leads_vc_title", value: "Choose Leads", comment: "Choose Leads VC Title")
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

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(ChooseLeadTableViewController.backButtonPressed(_:)))
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        leadChoosenDelegate.didChooseLead(sender: self, selectedLead: selectedLead)
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func reloadData() {
        self.tableView.reloadData()
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLeads() {
        leadsResultSet = realm.objects(Lead.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : ChooseLeadTableViewController")
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

        let leadCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadTableViewCellReuseIdentifier)
        leadCell.selectionStyle = .none
        leadCell.tintColor = UIColor(hexString: ProjectCloseColors.allTableViewCellTintColor)

        leadCell.textLabel?.text = lead.companyName
        leadCell.textLabel?.font = UIFont(name: ProjectCloseFonts.chooseLeadsTableViewControllerCompanyNameFont, size: 20.0)
        leadCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.chooseLeadsTableViewControllerCompanyNameColor)

        leadCell.detailTextLabel?.text = lead.companyDescription
        leadCell.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.chooseLeadsTableViewControllerCompanyDescriptionFont, size: 18.0)
        leadCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.chooseLeadsTableViewControllerCompanyDescriptionColor)

        if lead.leadId == previousSelectedLead.leadId {
            leadCell.accessoryType = .checkmark
            currentSelectedIndexPath = indexPath
        }

        return leadCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLead = leadsResultSet[indexPath.row]

        self.tableView?.cellForRow(at: currentSelectedIndexPath)?.accessoryType = .none
        self.tableView?.cellForRow(at: indexPath)?.accessoryType = .checkmark

        currentSelectedIndexPath = indexPath
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
