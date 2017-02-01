//
//  ChooseUserTableViewController.swift
//  ProjectClose
//
//  Created by raj on 01/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class ChooseUserTableViewController: UITableViewController {
    let userTableViewCellReuseIdentifier = "UserCell"

    var realm: Realm!
    var usersResultSet: Results<User>!

    var previousSelectedUserEmail: String!
    var currentSelectedIndexPath: IndexPath!
    
    var selectedUserEmail: String!
    var userChoosenDelegate: UserChoosenDelegate!

    init(email: String) {
        super.init(nibName: nil, bundle: nil)
        previousSelectedUserEmail = email
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
        loadUsers()
        
        reloadData()
    }

    func initTitle() {
        self.title = NSLocalizedString("choose_users_vc_title", value: "Choose Users", comment: "Choose Users VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: userTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.rowHeight = 75.0
        }
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(ChooseUserTableViewController.backButtonPressed(_:)))
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        userChoosenDelegate.didChooseUser(sender: self, selectedUserEmail: selectedUserEmail)
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadUsers() {
        usersResultSet = realm.objects(User.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : ChooseUserTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersResultSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = usersResultSet[indexPath.row]

        let name = user.name
        let email = user.email

        let userCell = UITableViewCell(style: .subtitle, reuseIdentifier: userTableViewCellReuseIdentifier)
        userCell.selectionStyle = .none
        userCell.tintColor = UIColor(hexString: ProjectCloseColors.allTableViewCellTintColor)

        userCell.textLabel?.text = name
        userCell.textLabel?.font = UIFont(name: ProjectCloseFonts.usersTableViewControllerNameFont, size: 20.0)
        userCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.usersTableViewControllerNameColor)

        userCell.detailTextLabel?.text = email
        userCell.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.usersTableViewControllerEmailFont, size: 18.0)
        userCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.usersTableViewControllerEmailColor)

        if user.email == previousSelectedUserEmail {
            userCell.accessoryType = .checkmark
            currentSelectedIndexPath = indexPath
//            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
        }
        

        return userCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = usersResultSet[indexPath.row]
        selectedUserEmail = selectedUser.email

        self.tableView?.cellForRow(at: currentSelectedIndexPath)?.accessoryType = .none
        self.tableView?.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        currentSelectedIndexPath = indexPath
    }

//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        self.tableView?.cellForRow(at: indexPath)?.accessoryType = .none
//    }

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
