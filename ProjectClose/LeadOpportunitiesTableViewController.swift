//
//  LeadOpportunitiesTableViewController.swift
//  ProjectClose
//
//  Created by raj on 23/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class LeadOpportunitiesTableViewController: UITableViewController, AddLeadOpportunityDelegate {
    let leadOpportunityTableViewCellReuseIdentifier = "LeadOpportunityCell"

    var leadId: String!

    var realm: Realm!
    var leadOpportunitiesResultSet: Results<Opportunity>!

    var leadOpportunityNotificationToken: NotificationToken!

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
        loadLeadOpportunities()
        listenForLeadOpportunitiesNotifications()
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLeadOpportunities() {
        leadOpportunitiesResultSet = realm.objects(Opportunity.self).filter(NSPredicate(format: "leadId == %@", leadId)).sorted(byKeyPath: "createdDate", ascending: false)
    }

    func listenForLeadOpportunitiesNotifications() {
        leadOpportunityNotificationToken = leadOpportunitiesResultSet.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
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

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(LeadOpportunityTableViewCell.classForCoder(), forCellReuseIdentifier: leadOpportunityTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.dataSource = self
            tableView.rowHeight = 75.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LeadOpportunitiesTableViewController")
    }


    deinit {
        leadOpportunityNotificationToken.stop()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leadOpportunitiesResultSet.count
    }

    func reloadTableView() {
        self.tableView?.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let opportunity = leadOpportunitiesResultSet[indexPath.row]

        let leadOpportunityCell = tableView.dequeueReusableCell(withIdentifier: leadOpportunityTableViewCellReuseIdentifier, for: indexPath) as! LeadOpportunityTableViewCell
        leadOpportunityCell.selectionStyle = .none

        leadOpportunityCell.confidencePercentage = opportunity.confidence

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        leadOpportunityCell.valueLabel.text = "$" + numberFormatter.string(from: NSNumber(value: opportunity.value))! + " Monthly"
        leadOpportunityCell.valueLabel.textColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerValueColor)
        leadOpportunityCell.valueLabel.font = UIFont(name: ProjectCloseFonts.leadOpportunitiesTableViewControllerValueFont, size: 20.0)

        leadOpportunityCell.userLabel.text = opportunity.assignedTo.name
        leadOpportunityCell.userLabel.textColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerAssignedToColor)
        leadOpportunityCell.userLabel.font = UIFont(name: ProjectCloseFonts.leadOpportunitiesTableViewControllerAssignedToFont, size: 18.0)

        leadOpportunityCell.confidencePercentageLabel.text = " \(opportunity.confidence)% "
        leadOpportunityCell.confidencePercentageLabel.textColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerPercentageColor)
        leadOpportunityCell.confidencePercentageLabel.font = UIFont(name: ProjectCloseFonts.leadOpportunitiesTableViewControllerPercentageFont, size: 14.0)

        leadOpportunityCell.statusLabel.text = opportunity.status
        if opportunity.status == "Closed" {
            leadOpportunityCell.statusLabel.textColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerClosedStatusColor)
        } else if opportunity.status == "Paused" {
            leadOpportunityCell.statusLabel.textColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerPausedStatusColor)
        } else {
            leadOpportunityCell.statusLabel.textColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerStatusColor)
        }
        leadOpportunityCell.statusLabel.font = UIFont(name: ProjectCloseFonts.leadOpportunitiesTableViewControllerStatusFont, size: 18.0)

        leadOpportunityCell.confidenceView.layer.borderColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerPercentageColor)?.cgColor
        leadOpportunityCell.confidenceView.layer.borderWidth = 1.5

        leadOpportunityCell.confidenceInPrecentageView.backgroundColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerPercentageColor)

        return leadOpportunityCell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let opportunity = leadOpportunitiesResultSet[indexPath.row]

        let activeStatusAction: UITableViewRowAction!
        let pauseStatusAction: UITableViewRowAction!
        let closeStatusAction: UITableViewRowAction!

        if opportunity.status == "Active" {
            pauseStatusAction = UITableViewRowAction(style: .default, title: "Pause", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Paused"
                }
            })
            pauseStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerPauseButtonColor)

            closeStatusAction = UITableViewRowAction(style: .default, title: "Close", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Closed"
                }
            })
            closeStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerClosedButtonColor)

            return [pauseStatusAction, closeStatusAction]
        } else if opportunity.status == "Paused" {
            activeStatusAction = UITableViewRowAction(style: .default, title: "Set Active", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Active"
                }
            })
            activeStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerActiveButtonColor)

            closeStatusAction = UITableViewRowAction(style: .default, title: "Close", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Closed"
                }
            })
            closeStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerClosedButtonColor)

            return [activeStatusAction, closeStatusAction]
        } else {
            activeStatusAction = UITableViewRowAction(style: .default, title: "Set Active", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Active"
                }
            })
            activeStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerActiveButtonColor)

            pauseStatusAction = UITableViewRowAction(style: .default, title: "Pause", handler: { [weak self] action, indexPath in
                try! self?.realm.write {
                    opportunity.status = "Paused"
                }
            })
            pauseStatusAction.backgroundColor = UIColor(hexString: ProjectCloseColors.leadOpportunityTableViewControllerPauseButtonColor)

            return [activeStatusAction, pauseStatusAction]
        }
    }

    func didFinishAddingLeadOpportunity(sender: AddLeadOpportunityViewController) {
    }

}
