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
    let leadCommsTableViewCellReuseIdentifier = "LeadCommsCell"
    let commsViewTag = 777

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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setupTableView()
        
        setupRealm()
        loadLeadContacts()
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: leadContactTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLeadContacts() {
        leadContactsResultSet = realm.objects(Contact.self).sorted(byProperty: "name")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LeadContactsTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leadContactsResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leadContact = leadContactsResultSet[indexPath.row]
        
        let leadContactCell = UITableViewCell(style: .subtitle, reuseIdentifier: leadContactTableViewCellReuseIdentifier)
        leadContactCell.selectionStyle = .none
        
        leadContactCell.textLabel?.text = leadContact.name
        leadContactCell.textLabel?.font = UIFont(name:  ProjectCloseFonts.leadContactsTableViewControllerTitleFont, size: 20.0)
        leadContactCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerTitleColor)
        
        leadContactCell.detailTextLabel?.text = leadContact.phone + " / " + leadContact.email
        leadContactCell.detailTextLabel?.font = UIFont(name:  ProjectCloseFonts.leadContactsTableViewControllerSubtitleFont, size: 18.0)
        leadContactCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerSubtitleColor)

        let commsView = UIView()
        commsView.translatesAutoresizingMaskIntoConstraints = false
        
        commsView.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerTableViewCellContactOptionsBackgroundViewColor)
        commsView.alpha = 0.0
        commsView.tag = commsViewTag

        leadContactCell.contentView.addSubview(commsView)

//        leadContactCell.contentView.addConstraint(commsView.widthAnchor.constraint(equalTo: (commsView.superview?.widthAnchor)!))
        leadContactCell.contentView.addConstraint(commsView.widthAnchor.constraint(equalTo: (commsView.superview?.widthAnchor)!))
//        leadContactCell.contentView.addConstraint(commsView.heightAnchor.constraint(equalToConstant: 75.0))
        leadContactCell.contentView.addConstraint(commsView.heightAnchor.constraint(equalTo: (commsView.superview?.heightAnchor)!, multiplier: 0.90))
        leadContactCell.contentView.addConstraint(commsView.centerXAnchor.constraint(equalTo: (commsView.superview?.centerXAnchor)!))
        leadContactCell.contentView.addConstraint(commsView.centerYAnchor.constraint(equalTo: (commsView.superview?.centerYAnchor)!))
//        leadContactCell.contentView.addConstraint(commsView.topAnchor.constraint(equalTo: (commsView.superview?.topAnchor)!))

        let commsStackView = createCommsStackView(for: indexPath)
        commsView.addSubview(commsStackView)
        
        commsView.addConstraint(commsStackView.widthAnchor.constraint(equalTo: (commsStackView.superview?.widthAnchor)!, multiplier: 0.95))
        commsView.addConstraint(commsStackView.heightAnchor.constraint(equalTo: (commsStackView.superview?.heightAnchor)!))
        commsView.addConstraint(commsStackView.centerXAnchor.constraint(equalTo: (commsStackView.superview?.centerXAnchor)!))
        commsView.addConstraint(commsStackView.centerYAnchor.constraint(equalTo: (commsStackView.superview?.centerYAnchor)!))
        
        return leadContactCell
    }

    func createCommsStackView(for indexPath: IndexPath) -> UIStackView {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false

        backButton.setImage(ProjectCloseUtilities.resizeImage(img: UIImage(named: "Close")!, to: CGSize(width: 32.0, height: 39.0)).withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.setImage(UIImage(named: "Close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.layer.cornerRadius = 60.0 / 2.0
        backButton.clipsToBounds = true
        backButton.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsButtonBackgroundColor)
        backButton.tintColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsOptionsImageTintColor)
        backButton.addTarget(self, action: #selector(LeadContactsTableViewController.backButtonPressed(_:)), for: .touchUpInside)

        let phoneButton = UIButton()
        phoneButton.translatesAutoresizingMaskIntoConstraints = false

        phoneButton.setImage(ProjectCloseUtilities.resizeImage(img: UIImage(named: "Phone")!, to: CGSize(width: 38.0, height: 39.0)).withRenderingMode(.alwaysTemplate), for: .normal)
        phoneButton.layer.cornerRadius = 60.0 / 2.0
        phoneButton.clipsToBounds = true
        phoneButton.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsButtonBackgroundColor)
        phoneButton.tintColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsOptionsImageTintColor)
        phoneButton.addTarget(self, action: #selector(LeadContactsTableViewController.phoneButtonPressed(_:)), for: .touchUpInside)
        
        let textMessageButton = UIButton()
        textMessageButton.translatesAutoresizingMaskIntoConstraints = false

        textMessageButton.setImage(ProjectCloseUtilities.resizeImage(img: UIImage(named: "TextMessage")!, to: CGSize(width: 38.0, height: 39.0)).withRenderingMode(.alwaysTemplate), for: .normal)
        textMessageButton.layer.cornerRadius = 60.0 / 2.0
        textMessageButton.clipsToBounds = true
        textMessageButton.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsButtonBackgroundColor)
        textMessageButton.tintColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerCommsOptionsImageTintColor)
        textMessageButton.addTarget(self, action: #selector(LeadContactsTableViewController.textMessageButtonPressed(_:)), for: .touchUpInside)
        
        let emailButton = UIButton()
        emailButton.translatesAutoresizingMaskIntoConstraints = false

        emailButton.setImage(ProjectCloseUtilities.resizeImage(img: UIImage(named: "Email")!, to: CGSize(width: 38.0, height: 39.0)).withRenderingMode(.alwaysTemplate), for: .normal)
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
        print(leadContactsResultSet[selectedIndexPath.row].name)
        print("Back button pressed.")
        let selectedCell = tableView.cellForRow(at: selectedIndexPath)
        let commsView = selectedCell?.contentView.viewWithTag(commsViewTag)
        commsView?.alpha = 0.0
    }

    func phoneButtonPressed(_ sender: UIButton) {
        let phoneNumber = leadContactsResultSet[selectedIndexPath.row].phone
        if let url = NSURL(string: "tel://" + phoneNumber!), UIApplication.shared.canOpenURL(url as URL) {
            print(url)
            print(phoneNumber!)
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.openURL(url as URL)
            }
        } else {
            print("Cannot make call with the selected phone number.")
        }
    }
    
    func textMessageButtonPressed(_ sender: UIButton) {
        print(leadContactsResultSet[selectedIndexPath.row].name)
        print("Text Message button pressed.")
    }
    
    func emailButtonPressed(_ sender: UIButton) {
        print(leadContactsResultSet[selectedIndexPath.row].name)
        print("Email Message button pressed.")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        let commsView = selectedCell?.contentView.viewWithTag(commsViewTag)
        commsView?.alpha = 1.0
//        selectedCell?.backgroundColor = UIColor(hexString: ProjectCloseColors.leadContactsTableViewControllerTableViewCellContactOptionsBackgroundViewColor)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        let commsView = selectedCell?.contentView.viewWithTag(commsViewTag)
        commsView?.alpha = 0.0
//        let deSelectedCell = tableView.cellForRow(at: indexPath)
//        deSelectedCell?.backgroundColor = .white
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
