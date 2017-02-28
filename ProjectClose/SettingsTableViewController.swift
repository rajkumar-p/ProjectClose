//
//  SettingsTableViewController.swift
//  ProjectClose
//
//  Created by raj on 18/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    enum SettingsRow { case profileDetails; case sectionHeader; case sectionDetail; case sectionEmpty; case button }

    let rowCount = 12
    let rowContentType: [SettingsRow] = [SettingsRow.profileDetails, SettingsRow.sectionHeader, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionHeader, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionDetail]
//    let rowCount = 13
//    let rowContentType: [SettingsRow] = [SettingsRow.profileDetails, SettingsRow.sectionEmpty, SettingsRow.sectionHeader, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionEmpty, SettingsRow.sectionHeader, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionDetail, SettingsRow.sectionEmpty, SettingsRow.button]
    let rowContent = ["", "Your Settings", "Profile", "Audio", "Organizations", "Diskodev.com's Settings", "Users", "Plans & Billing", "API Keys", "Templates", "Phone Settings", "Email Settings"]

    let settingsProfileDetailsTableViewCellReuseIdentifier = "SettingsProfileDetailsTableViewCell"
    let settingsSectionHeaderTableViewCellReuseIdentifier = "SectionHeaderTableViewCell"
    let settingsSectionDetailTableViewCellReuseIdentifier = "SectionDetailTableViewCell"
    let settingsSectionEmptyTableViewCellReuseIdentifier = "SectionEmptyTableViewCell"
    let settingsButtonTableViewCellReuseIdentifier = "SettingsButtonTableViewCell"

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
        setupTableView()
    }
  
    func initTitle() {
        self.title = NSLocalizedString("settings_table_vc_title", value: "Settings", comment: "Settings Table VC title")
    }

    func setupView() {
        setupTableView()
    }

    func setupTableView() {
        if let tableView = self.tableView {
            tableView.register(UserProfileTableViewCell.classForCoder(), forCellReuseIdentifier: settingsProfileDetailsTableViewCellReuseIdentifier)
//            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: settingsProfileDetailsTableViewCellReuseIdentifier)
            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: settingsSectionHeaderTableViewCellReuseIdentifier)
            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: settingsSectionDetailTableViewCellReuseIdentifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : SettingsTableViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rowContentType[indexPath.row] {
            case .profileDetails:
                return makeProfileDetailsTableViewCell()
            case .sectionHeader:
                return makeSectionHeaderTableViewCell(indexPath: indexPath)
            case .sectionDetail:
                return makeSectionDetailTableViewCell(indexPath: indexPath)
            case .sectionEmpty:
                return makeSectionEmptyTableViewCell()
            case .button:
                return makeButtonTableViewCell(indexPath: indexPath)
        }
    }

    func makeProfileDetailsTableViewCell() -> UITableViewCell {
//        let profileDetailsCell = UITableViewCell(style: .subtitle, reuseIdentifier: settingsProfileDetailsTableViewCellReuseIdentifier)
//
//        let resizedProfileImage = ProjectCloseUtilities.resizeImage(img: UIImage(named: ProjectCloseStrings.settingsTableViewControllerProfileImageName)!, to: CGSize(width: 70.0, height: 70.0))
//
////        profileDetailsCell.imageView?.layer.borderWidth = 1.0
////        profileDetailsCell.imageView?.layer.borderColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerProfileImageBorderColor)?.cgColor
//
////        profileDetailsCell.imageView?.contentMode = .scaleAspectFit
////        profileDetailsCell.imageView?.transform = CGAffineTransform(scaleX: 0.20, y: 0.20)
//
//        profileDetailsCell.imageView?.contentMode = .scaleAspectFill
//        profileDetailsCell.imageView?.layer.cornerRadius = 35.0
//        profileDetailsCell.imageView?.clipsToBounds = true
//        profileDetailsCell.imageView?.image = resizedProfileImage
//
//        profileDetailsCell.textLabel?.text = "Rajkumar P"
//        profileDetailsCell.textLabel?.font = UIFont(name: ProjectCloseFonts.settingsTableViewControllerNameFont, size: 20.0)
//        profileDetailsCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerNameTitleColor)
//
//        profileDetailsCell.detailTextLabel?.text = "raj@diskodev.com"
//        profileDetailsCell.detailTextLabel?.font = UIFont(name: ProjectCloseFonts.settingsTableViewControllerEmailFont, size: 18.0)
//        profileDetailsCell.detailTextLabel?.textColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerEmailTitleColor)
//
//        profileDetailsCell.selectionStyle = .none
//
//        return profileDetailsCell

        let profileDetailsCell = UserProfileTableViewCell(style: .default, reuseIdentifier: settingsProfileDetailsTableViewCellReuseIdentifier)
        profileDetailsCell.selectionStyle = .none

        profileDetailsCell.avatarButton.setImage(UIImage(named: ProjectCloseStrings.settingsTableViewControllerProfileImageName)!, for: .normal)
//        profileDetailsCell.avatarImageView.image = UIImage(named: ProjectCloseStrings.settingsTableViewControllerProfileImageName)
//        profileDetailsCell.avatarImageView?.contentMode = .scaleAspectFit

        profileDetailsCell.mainLabel?.text = "Rajkumar P"
        profileDetailsCell.mainLabel?.font = UIFont(name: ProjectCloseFonts.userProfileTableViewCellMainLabelFont, size: 20.0)
        profileDetailsCell.mainLabel?.textColor = UIColor(hexString: ProjectCloseColors.userProfileTableViewCellMainLabelColor)

        profileDetailsCell.subTitleLabel?.text = "raj@diskodev.com"
        profileDetailsCell.subTitleLabel?.font = UIFont(name: ProjectCloseFonts.userProfileTableViewCellSubTitleLabelFont, size: 18.0)
        profileDetailsCell.subTitleLabel?.textColor = UIColor(hexString: ProjectCloseColors.userProfileTableViewCellSubTitleLabelColor)

        profileDetailsCell.logoutButton?.setTitle("LOG OUT", for: .normal)
        profileDetailsCell.logoutButton?.backgroundColor = UIColor(hexString: ProjectCloseColors.userProfileTableViewCellLogoutButtonBackgroundColor)
        profileDetailsCell.logoutButton?.titleLabel?.font = UIFont(name: ProjectCloseFonts.userProfileTableViewCellSubTitleLabelFont, size: 14.0)

        return profileDetailsCell
    }
    
    func makeSectionHeaderTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let sectionHeaderCell = UITableViewCell(style: .subtitle, reuseIdentifier: settingsSectionHeaderTableViewCellReuseIdentifier)
        
        sectionHeaderCell.textLabel?.text = rowContent[indexPath.row]
        sectionHeaderCell.textLabel?.font = UIFont(name: ProjectCloseFonts.settingsTableViewControllerHeaderFont, size: 20.0)
        sectionHeaderCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerEmailTitleColor)
//        sectionHeaderCell.backgroundColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerHeaderBackgroundColor, withAlpha: 0.4)
//        sectionHeaderCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerHeaderTitleColor)
        
        sectionHeaderCell.selectionStyle = .none

        return sectionHeaderCell
    }
    
    func makeSectionDetailTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let sectionDetailCell = UITableViewCell(style: .subtitle, reuseIdentifier: settingsSectionDetailTableViewCellReuseIdentifier)

        sectionDetailCell.textLabel?.text = rowContent[indexPath.row]
        sectionDetailCell.textLabel?.font = UIFont(name: ProjectCloseFonts.settingsTableViewControllerContentFont, size: 20.0)
        sectionDetailCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerContentColor)
        
        sectionDetailCell.selectedBackgroundView = { let selectedBackgroundView = UIView(); selectedBackgroundView.backgroundColor = .clear; return selectedBackgroundView }()

        return sectionDetailCell
    }

    func makeSectionEmptyTableViewCell() -> UITableViewCell {
        let sectionEmptyCell = UITableViewCell(style: .default, reuseIdentifier: settingsSectionEmptyTableViewCellReuseIdentifier)
        sectionEmptyCell.selectionStyle = .none
        
        return sectionEmptyCell
    }
    
    func makeButtonTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let buttonCell = UITableViewCell(style: .default, reuseIdentifier: settingsButtonTableViewCellReuseIdentifier)

        let logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        logoutButton.setTitle(rowContent[indexPath.row], for: .normal)
        logoutButton.setTitleColor(UIColor(hexString: ProjectCloseColors.settingsTableViewControllerLogoutButtonTitleColor), for: .normal)
        logoutButton.backgroundColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerLogoutButtonBackgroundColor)
        logoutButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.settingsTableViewControllerLogoutButtonFont, size: 20.0)

//        logoutButton.layer.cornerRadius = 10.0
//        logoutButton.layer.borderWidth = 2.5
//        logoutButton.layer.borderColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerLogoutButtonBackgroundColor)?.cgColor

        buttonCell.contentView.addSubview(logoutButton)

        buttonCell.contentView.addConstraint(logoutButton.widthAnchor.constraint(equalTo: (logoutButton.superview?.widthAnchor)!))
        buttonCell.contentView.addConstraint(logoutButton.heightAnchor.constraint(equalTo: (logoutButton.superview?.heightAnchor)!, multiplier: 0.80))
        buttonCell.contentView.addConstraint(logoutButton.centerXAnchor.constraint(equalTo: (logoutButton.superview?.centerXAnchor)!))
        buttonCell.contentView.addConstraint(logoutButton.centerYAnchor.constraint(equalTo: (logoutButton.superview?.centerYAnchor)!))
//        buttonCell.textLabel?.text = rowContent[indexPath.row]
//        buttonCell.textLabel?.font = UIFont(name: ProjectCloseFonts.settingsTableViewControllerLogoutButtonFont, size: 20.0)
//        buttonCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerLogoutButtonBackgroundColor)
////        buttonCell.textLabel?.textColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerLogoutButtonTitleColor)
//        buttonCell.textLabel?.textAlignment = .center
//
////        buttonCell.backgroundColor = UIColor(hexString: ProjectCloseColors.settingsTableViewControllerLogoutButtonBackgroundColor)
//        buttonCell.selectedBackgroundView = { let selectedBackgroundView = UIView(); selectedBackgroundView.backgroundColor = .clear; return selectedBackgroundView }()
//
        return buttonCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch rowContentType[indexPath.row] {
            case .profileDetails:
                return 75.0
            case .sectionHeader:
                return 50.0
            case .sectionDetail:
                return 50.0
            case .sectionEmpty:
                return 50.0
            case .button:
                return 50.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if rowContent[indexPath.row] == "Users" {
            let usersTableViewController = UsersTableViewController()
            self.navigationController?.pushViewController(usersTableViewController, animated: true)
        }
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
