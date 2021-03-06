//
//  LeadContactsTableViewController.swift
//  ProjectClose
//
//  Created by raj on 23/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class LeadContactsTableViewController: UITableViewController, AddLeadContactDelegate {
    let leadContactTableViewCellReuseIdentifier = "LeadContactCell"
    let commsViewTag = 777

    var leadId: String!

    var realm: Realm!
    var leadContactsResultSet: Results<Contact>!

    var selectedIndexPath: IndexPath!

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
        loadLeadContacts()
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

    func loadLeadContacts() {
        leadContactsResultSet = realm.objects(Contact.self).filter(NSPredicate(format: "leadId == %@", leadId)).sorted(byKeyPath: "name")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LeadContactsTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leadContactsResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leadContact = leadContactsResultSet[indexPath.row]
        
        var leadContactCell = tableView.dequeueReusableCell(withIdentifier: leadContactTableViewCellReuseIdentifier)

        if leadContactCell == nil {
            leadContactCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadContactTableViewCellReuseIdentifier)
        }

        leadContactCell?.selectionStyle = .none
        
        leadContactCell?.textLabel?.text = leadContact.name
        leadContactCell?.textLabel?.font = UIFont(name:  ProjectCloseFonts.leadContactsTableViewControllerTitleFont, size: 20.0)
        leadContactCell?.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerTitleColor)
        
        leadContactCell?.detailTextLabel?.text = leadContact.phone + " / " + leadContact.email
        leadContactCell?.detailTextLabel?.font = UIFont(name:  ProjectCloseFonts.leadContactsTableViewControllerSubtitleFont, size: 18.0)
        leadContactCell?.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerSubtitleColor)

        let commsView = UIView()
        commsView.translatesAutoresizingMaskIntoConstraints = false
        
        commsView.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerTableViewCellContactOptionsBackgroundViewColor)
        commsView.alpha = 0.0
        commsView.tag = commsViewTag

        leadContactCell?.contentView.addSubview(commsView)

        leadContactCell?.contentView.addConstraint(commsView.widthAnchor.constraint(equalTo: (commsView.superview?.widthAnchor)!))
        leadContactCell?.contentView.addConstraint(commsView.heightAnchor.constraint(equalTo: (commsView.superview?.heightAnchor)!, multiplier: 0.90))
        leadContactCell?.contentView.addConstraint(commsView.centerXAnchor.constraint(equalTo: (commsView.superview?.centerXAnchor)!))
        leadContactCell?.contentView.addConstraint(commsView.centerYAnchor.constraint(equalTo: (commsView.superview?.centerYAnchor)!))

        let commsStackView = createCommsStackView(for: indexPath)
        commsView.addSubview(commsStackView)
        
        commsView.addConstraint(commsStackView.widthAnchor.constraint(equalTo: (commsStackView.superview?.widthAnchor)!, multiplier: 0.95))
        commsView.addConstraint(commsStackView.heightAnchor.constraint(equalTo: (commsStackView.superview?.heightAnchor)!))
        commsView.addConstraint(commsStackView.centerXAnchor.constraint(equalTo: (commsStackView.superview?.centerXAnchor)!))
        commsView.addConstraint(commsStackView.centerYAnchor.constraint(equalTo: (commsStackView.superview?.centerYAnchor)!))
        
        return leadContactCell!
    }

    func createCommsStackView(for indexPath: IndexPath) -> UIStackView {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false

        backButton.setImage(UIImage(named: ProjectCloseStrings.leadContactsTableViewControllerContactBackImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.layer.cornerRadius = 60.0 / 2.0
        backButton.clipsToBounds = true
        backButton.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsButtonBackgroundColor)
        backButton.tintColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsOptionsImageTintColor)
        backButton.addTarget(self, action: #selector(LeadContactsTableViewController.backButtonPressed(_:)), for: .touchUpInside)

        let phoneButton = UIButton()
        phoneButton.translatesAutoresizingMaskIntoConstraints = false

        phoneButton.setImage(UIImage(named: ProjectCloseStrings.leadContactsTableViewControllerContactPhoneImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        phoneButton.layer.cornerRadius = 60.0 / 2.0
        phoneButton.clipsToBounds = true
        phoneButton.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsButtonBackgroundColor)
        phoneButton.tintColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsOptionsImageTintColor)
        phoneButton.addTarget(self, action: #selector(LeadContactsTableViewController.phoneButtonPressed(_:)), for: .touchUpInside)
        
        let textMessageButton = UIButton()
        textMessageButton.translatesAutoresizingMaskIntoConstraints = false

        textMessageButton.setImage(UIImage(named: ProjectCloseStrings.leadContactsTableViewControllerContactTextMessageImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        textMessageButton.layer.cornerRadius = 60.0 / 2.0
        textMessageButton.clipsToBounds = true
        textMessageButton.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsButtonBackgroundColor)
        textMessageButton.tintColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsOptionsImageTintColor)
        textMessageButton.addTarget(self, action: #selector(LeadContactsTableViewController.textMessageButtonPressed(_:)), for: .touchUpInside)
        
        let emailButton = UIButton()
        emailButton.translatesAutoresizingMaskIntoConstraints = false

        emailButton.setImage(UIImage(named: ProjectCloseStrings.leadContactsTableViewControllerContactEmailImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        emailButton.layer.cornerRadius = 60.0 / 2.0
        emailButton.clipsToBounds = true
        emailButton.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsButtonBackgroundColor)
        emailButton.tintColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsOptionsImageTintColor)
        emailButton.addTarget(self, action: #selector(LeadContactsTableViewController.emailButtonPressed(_:)), for: .touchUpInside)

        let commsStackView = UIStackView()
        commsStackView.translatesAutoresizingMaskIntoConstraints = false

        commsStackView.axis = .horizontal
        commsStackView.distribution = .equalSpacing
        commsStackView.alignment = .center
        commsStackView.spacing = 8.0

        commsStackView.addArrangedSubview(backButton)
        commsStackView.addArrangedSubview(phoneButton)
        commsStackView.addArrangedSubview(textMessageButton)
        commsStackView.addArrangedSubview(emailButton)

        commsStackView.addConstraint(backButton.widthAnchor.constraint(equalToConstant: 60.0))
        commsStackView.addConstraint(backButton.heightAnchor.constraint(equalToConstant: 60.0))

        commsStackView.addConstraint(phoneButton.widthAnchor.constraint(equalToConstant: 60.0))
        commsStackView.addConstraint(phoneButton.heightAnchor.constraint(equalToConstant: 60.0))

        commsStackView.addConstraint(textMessageButton.widthAnchor.constraint(equalToConstant: 60.0))
        commsStackView.addConstraint(textMessageButton.heightAnchor.constraint(equalToConstant: 60.0))

        commsStackView.addConstraint(emailButton.widthAnchor.constraint(equalToConstant: 60.0))
        commsStackView.addConstraint(emailButton.heightAnchor.constraint(equalToConstant: 60.0))

        return commsStackView
    }

    func backButtonPressed(_ sender: UIButton) {
        let selectedCell = tableView.cellForRow(at: selectedIndexPath)
        let commsView = selectedCell?.contentView.viewWithTag(commsViewTag)
        commsView?.alpha = 0.0
    }

    func phoneButtonPressed(_ sender: UIButton) {
        let phoneNumber = leadContactsResultSet[selectedIndexPath.row].phone
        if let url = NSURL(string: "tel://" + phoneNumber!), UIApplication.shared.canOpenURL(url as URL) {
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.openURL(url as URL)
            }
        } else {
            print("Cannot make call with the selected phone number.")
        }
    }
    
    func textMessageButtonPressed(_ sender: UIButton) {
    }
    
    func emailButtonPressed(_ sender: UIButton) {
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        let commsView = selectedCell?.contentView.viewWithTag(commsViewTag)
        commsView?.alpha = 1.0
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        let commsView = selectedCell?.contentView.viewWithTag(commsViewTag)
        commsView?.alpha = 0.0
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
            let leadContactToBeDeleted = leadContactsResultSet[indexPath.row]
            try! realm.write {
                realm.delete(leadContactToBeDeleted)
            }

            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    func didFinishAddingLeadContact(sender: AddLeadContactViewController) {
        reloadTableViewData()
    }

    func reloadTableViewData() {
        self.tableView.reloadData()
    }

}
