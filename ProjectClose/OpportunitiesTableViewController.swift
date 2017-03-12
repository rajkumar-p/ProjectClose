//
//  OpportunitiesTableViewController.swift
//  ProjectClose
//
//  Created by raj on 09/03/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class OpportunitiesTableViewController: UITableViewController, AddOpportunityDelegate {
    let opportunityTableViewCellReuseIdentifier = "OpportunityCell"

    var realm: Realm!
    var opportunitiesResultSet: Results<Opportunity>!
    var opportunitiesNotificationToken: NotificationToken!

    init() {
        super.init(nibName: nil, bundle: nil)
        initTitle()

        setupAddTaskButton()
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
        loadOpportunities()
        listenForOpportunitiesNotifications()
    }

    func initTitle() {
        self.title = NSLocalizedString("opportunities_table_vc_title", value: "Opportunities", comment: "Opportunities Table VC title")
    }

    func setupAddTaskButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(OpportunitiesTableViewController.addTaskButtonPressed(_:)))
        rightBarButtonItem.tintColor = UIColor(hexString: ProjectCloseColors.opportunitiesViewControllerAddLeadButtonColor)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func addTaskButtonPressed(_ sender: UIBarButtonItem) {
        let addOpportunityViewController = AddOpportunityViewController()
        addOpportunityViewController.addOpportunityDelegate = self

        self.navigationController?.pushViewController(addOpportunityViewController, animated: true)
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(OpportunityTableViewCell.classForCoder(), forCellReuseIdentifier: opportunityTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadOpportunities() {
        opportunitiesResultSet = realm.objects(Opportunity.self).sorted(byKeyPath: "createdDate", ascending: false)
    }

    func listenForOpportunitiesNotifications() {
        opportunitiesNotificationToken = opportunitiesResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                print("Initial - OpportunitiesTableViewController")
                self?.reloadTableView()
                break
            case .update(_, let deletions, let insertions, let modifications):
                print("Update - OpportunitiesTableViewController")
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

    deinit {
        opportunitiesNotificationToken.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : OpportunitiesTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return opportunitiesResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let opportunity = opportunitiesResultSet[indexPath.row]
        let leadForOpportunity = realm.object(ofType: Lead.self, forPrimaryKey: opportunity.leadId)

        let opportunityCell = OpportunityTableViewCell(style: .default, reuseIdentifier: opportunityTableViewCellReuseIdentifier, confidencePercentage: opportunity.confidence)
        opportunityCell.selectionStyle = .none

        opportunityCell.leadLabel?.text = leadForOpportunity?.shortIdentifier
        opportunityCell.leadLabel?.textAlignment = .center
        opportunityCell.leadLabel?.textColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellLeadLabelTitleColor)
        opportunityCell.leadLabel?.font = UIFont(name: ProjectCloseFonts.opportunityTableViewCellLeadLabelTitleFont, size: 20.0)

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        opportunityCell.valueLabel.text = "$" + numberFormatter.string(from: NSNumber(value: opportunity.value))! + " Monthly"
        opportunityCell.valueLabel.textColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellValueColor)
        opportunityCell.valueLabel.font = UIFont(name: ProjectCloseFonts.opportunityTableViewCellValueFont, size: 20.0)

        opportunityCell.userLabel.text = opportunity.assignedTo.name
        opportunityCell.userLabel.textColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellAssignedToColor)
        opportunityCell.userLabel.font = UIFont(name: ProjectCloseFonts.opportunityTableViewCellAssignedToFont, size: 18.0)

        opportunityCell.confidencePercentageLabel.text = " \(opportunity.confidence)% "
        opportunityCell.confidencePercentageLabel.textColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellPercentageColor)
        opportunityCell.confidencePercentageLabel.font = UIFont(name: ProjectCloseFonts.opportunityTableViewCellPercentageFont, size: 14.0)

        opportunityCell.statusLabel.text = opportunity.status
        if opportunity.status == "Closed" {
            opportunityCell.statusLabel.textColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellClosedStatusColor)
        } else if opportunity.status == "Paused" {
            opportunityCell.statusLabel.textColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerPausedStatusColor)
        } else {
            opportunityCell.statusLabel.textColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellStatusColor)
        }
        opportunityCell.statusLabel.font = UIFont(name: ProjectCloseFonts.opportunityTableViewCellStatusFont, size: 18.0)

        opportunityCell.confidenceView.layer.borderColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellPercentageViewBorderColor)?.cgColor
        opportunityCell.confidenceView.layer.borderWidth = 1.5

        opportunityCell.confidenceInPrecentageView.backgroundColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellPercentageColor)

        return opportunityCell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let opportunity = opportunitiesResultSet[indexPath.row]

        let activeStatusAction: UITableViewRowAction!
        let pauseStatusAction: UITableViewRowAction!
        let closeStatusAction: UITableViewRowAction!

        if opportunity.status == "Active" {
            pauseStatusAction = UITableViewRowAction(style: .default, title: "Pause", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Paused"
                }
            })
            pauseStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellPauseButtonColor)

            closeStatusAction = UITableViewRowAction(style: .default, title: "Close", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Closed"
                }
            })
            closeStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellCloseButtonColor)

            return [pauseStatusAction, closeStatusAction]
        } else if opportunity.status == "Paused" {
            activeStatusAction = UITableViewRowAction(style: .default, title: "Set Active", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Active"
                }
            })
            activeStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellSetActiveButtonColor)

            closeStatusAction = UITableViewRowAction(style: .default, title: "Close", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Closed"
                }
            })
            closeStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellCloseButtonColor)

            return [activeStatusAction, closeStatusAction]
        } else {
            activeStatusAction = UITableViewRowAction(style: .default, title: "Set Active", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Active"
                }
            })
            activeStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellSetActiveButtonColor)

            pauseStatusAction = UITableViewRowAction(style: .default, title: "Pause", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Paused"
                }
            })
            pauseStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.opportunityTableViewCellPauseButtonColor)

            return [activeStatusAction, pauseStatusAction]
        }
    }

    func reloadTableView() {
        self.tableView?.reloadData()
    }
    
    func didFinishAddingOpportunity(sender: AddOpportunityViewController) {
        print("Finish adding Opportunity.")
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