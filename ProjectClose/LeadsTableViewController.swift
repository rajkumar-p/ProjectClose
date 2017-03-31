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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leadsResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lead = leadsResultSet[indexPath.row]

        let companyName = lead.companyName
        let status = lead.status
        
        var leadCell = tableView.dequeueReusableCell(withIdentifier: leadTableViewCellReuseIdentifier)

        if leadCell == nil {
            leadCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadTableViewCellReuseIdentifier)
        }

        leadCell?.textLabel?.text = companyName
        leadCell?.textLabel?.font = UIFont(name: ProjectCloseFonts.leadsTableViewControllerCompanyName, size: 20.0)
        leadCell?.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadsTableViewControllerCompanyNameColor)

        leadCell?.detailTextLabel?.text = status
        leadCell?.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.leadsTableViewControllerStatus, size: 18.0)
        leadCell?.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadsTableViewControllerStatusColor)

        return leadCell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLead = leadsResultSet[indexPath.row]
        
        let leadDetailsContainerViewController = LeadDetailsContainerViewController(leadId: selectedLead.leadId)
        leadDetailsContainerViewController.changeDelegate = self

        let leadDetailsPagingMenuViewController = makeLeadDetailsPagingViewController(leadId: selectedLead.leadId)

        leadDetailsContainerViewController.addChildViewController(leadDetailsPagingMenuViewController)
        leadDetailsContainerViewController.view.addSubview(leadDetailsPagingMenuViewController.view)

        leadDetailsPagingMenuViewController.didMove(toParentViewController: self)

        self.navigationController?.pushViewController(leadDetailsContainerViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView!.setEditing(editing, animated: animated)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let lead = leadsResultSet[indexPath.row]
            try! realm.write {
                realm.delete(lead)
            }

            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    func didFinishAddingLead(sender: AddLeadViewController) {
        reloadTableView()
    }

    func didChangeLead(sender: LeadDetailsContainerViewController) {
        reloadTableView()
    }

}
