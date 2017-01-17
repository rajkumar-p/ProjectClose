//
//  SettingsViewController.swift
//  ProjectClose
//
//  Created by raj on 06/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var emailLabel: UILabel!

    var yourSettingLabel: UILabel!
    var orgSettingLabel: UILabel!

    var yourProfileSettingButton: UIButton!
    var yourAudioSettingButton: UIButton!

    var orgUsersSettingButton: UIButton!

    var logoutButton: UIButton!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        initTitle()
//        ProjectCloseUtilities.styleTabBarItem(tabBarItem: self.tabBarItem, imageName: ProjectCloseStrings.settingsNavigationControllerSettingsImageName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupProfileImageView()
        setupNameLabel()
        setupEmailLabel()

        setupYourSettingLabel()
        setupYourProfileSettingButton()
        setupYourAudioSettingButton()

        setupOrgSettingLabel()
        setupOrgUsersSettingLabel()
        setupLogoutButton()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        changeProfileImageViewWidth()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeProfileImageViewWidth()
    }

    func initTitle() {
        self.title = NSLocalizedString("settings_vc_title", value: "Settings", comment: "Settings VC title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupProfileImageView() {
        profileImageView = UIImageView(image: UIImage(named: ProjectCloseStrings.settingsViewControllerProfileImageName))
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerProfileImageBorderColor)?.cgColor

        self.view.addSubview(profileImageView)

        self.view.addConstraint(profileImageView.heightAnchor.constraint(equalToConstant: 100.0))
        self.view.addConstraint(profileImageView.widthAnchor.constraint(equalToConstant: 100.0))
        self.view.addConstraint(profileImageView.topAnchor.constraint(equalTo: (profileImageView.superview?.topAnchor)!, constant: 30.0))
        self.view.addConstraint(profileImageView.centerXAnchor.constraint(equalTo: (profileImageView.superview?.centerXAnchor)!))
    }

    func changeProfileImageViewWidth() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2.0
        profileImageView.clipsToBounds = true
    }

    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.text = "Rajkumar P"
        nameLabel.textColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerNameTitleColor)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: ProjectCloseFonts.settingsViewControllerNameFont, size: 22.0)
        nameLabel.sizeToFit()

        self.view.addSubview(nameLabel)

        self.view.addConstraint(nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20.0))
        self.view.addConstraint(nameLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(nameLabel.centerXAnchor.constraint(equalTo: (nameLabel.superview?.centerXAnchor)!))
    }

    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false

        emailLabel.text = "raj@diskodev.com"
        emailLabel.textColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerEmailTitleColor)
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont(name: ProjectCloseFonts.settingsViewControllerEmailFont, size: 17.0)
        emailLabel.sizeToFit()

        self.view.addSubview(emailLabel)

        self.view.addConstraint(emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2.0))
        self.view.addConstraint(emailLabel.heightAnchor.constraint(equalToConstant: 30.0))
        self.view.addConstraint(emailLabel.centerXAnchor.constraint(equalTo: (emailLabel.superview?.centerXAnchor)!))
    }

    func setupYourSettingLabel() {
        yourSettingLabel = UILabel()
        yourSettingLabel.translatesAutoresizingMaskIntoConstraints = false

        yourSettingLabel.text = NSLocalizedString("settings_vc_your_settings_title", value: " Your Settings",comment: "Setting VC Your Settings Title")
        yourSettingLabel.backgroundColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerYourSettingsLabelBackgroundColor)
        yourSettingLabel.textColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerYourSettingsLabelTitleColor)
        yourSettingLabel.textAlignment = .left
        yourSettingLabel.font = UIFont(name: ProjectCloseFonts.settingsViewControllerYourSettingsLabelTitleFont, size: 20.0)

        self.view.addSubview(yourSettingLabel)

        self.view.addConstraint(yourSettingLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30.0))
        self.view.addConstraint(yourSettingLabel.widthAnchor.constraint(equalTo: (yourSettingLabel.superview?.widthAnchor)!))
        self.view.addConstraint(yourSettingLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupYourProfileSettingButton() {
        yourProfileSettingButton = UIButton()
        yourProfileSettingButton.translatesAutoresizingMaskIntoConstraints = false

        yourProfileSettingButton.setTitle(NSLocalizedString("settings_vc_your_profile_settings_title", value: " Profile",comment: "Setting VC Your Profile Settings Title"), for: .normal)
        yourProfileSettingButton.setTitleColor(UIColor(hexString: ProjectCloseColors.settingsViewControllerYourProfileSettingsButtonTitleColor), for: .normal)
        yourProfileSettingButton.contentHorizontalAlignment = .left
        yourProfileSettingButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.settingsViewControllerYourProfileSettingsButtonTitleFont, size: 20.0)

        self.view.addSubview(yourProfileSettingButton)

        self.view.addConstraint(yourProfileSettingButton.topAnchor.constraint(equalTo: yourSettingLabel.bottomAnchor))
        self.view.addConstraint(yourProfileSettingButton.widthAnchor.constraint(equalTo: (yourProfileSettingButton.superview?.widthAnchor)!))
        self.view.addConstraint(yourProfileSettingButton.heightAnchor.constraint(equalToConstant: 35.0))
    }

    func setupYourAudioSettingButton() {
        yourAudioSettingButton = UIButton()
        yourAudioSettingButton.translatesAutoresizingMaskIntoConstraints = false

        yourAudioSettingButton.setTitle(NSLocalizedString("settings_vc_your_audio_settings_title", value: " Audio",comment: "Setting VC Your Audio Settings Title"), for: .normal)
        yourAudioSettingButton.setTitleColor(UIColor(hexString: ProjectCloseColors.settingsViewControllerYourAudioSettingsButtonTitleColor), for: .normal)
        yourAudioSettingButton.contentHorizontalAlignment = .left
        yourAudioSettingButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.settingsViewControllerYourAudioSettingsButtonTitleFont, size: 20.0)

        self.view.addSubview(yourAudioSettingButton)

        self.view.addConstraint(yourAudioSettingButton.topAnchor.constraint(equalTo: yourProfileSettingButton.bottomAnchor))
        self.view.addConstraint(yourAudioSettingButton.widthAnchor.constraint(equalTo: (yourAudioSettingButton.superview?.widthAnchor)!))
        self.view.addConstraint(yourAudioSettingButton.heightAnchor.constraint(equalToConstant: 35.0))
    }

    func setupOrgSettingLabel() {
        orgSettingLabel = UILabel()
        orgSettingLabel.translatesAutoresizingMaskIntoConstraints = false

        orgSettingLabel.text = NSLocalizedString("settings_vc_org_settings_title", value: " Diskodev.com's Settings",comment: "Setting VC Your Org Settings Title")
        orgSettingLabel.backgroundColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerOrgSettingsLabelBackgroundColor)
        orgSettingLabel.textColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerOrgSettingsLabelTitleColor)
        orgSettingLabel.textAlignment = .left
        orgSettingLabel.font = UIFont(name: ProjectCloseFonts.settingsViewControllerOrgSettingsLabelTitleFont, size: 20.0)

        self.view.addSubview(orgSettingLabel)

        self.view.addConstraint(orgSettingLabel.topAnchor.constraint(equalTo: yourAudioSettingButton.bottomAnchor, constant: 30.0))
        self.view.addConstraint(orgSettingLabel.widthAnchor.constraint(equalTo: (orgSettingLabel.superview?.widthAnchor)!))
        self.view.addConstraint(orgSettingLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOrgUsersSettingLabel() {
        orgUsersSettingButton = UIButton()
        orgUsersSettingButton.translatesAutoresizingMaskIntoConstraints = false

        orgUsersSettingButton.setTitle(NSLocalizedString("settings_vc_org_users_settings_title", value: " Users",comment: "Setting VC Org Users Settings Title"), for: .normal)
        orgUsersSettingButton.setTitleColor(UIColor(hexString: ProjectCloseColors.settingsViewControllerOrgUsersSettingsButtonTitleColor), for: .normal)
        orgUsersSettingButton.contentHorizontalAlignment = .left
        orgUsersSettingButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.settingsViewControllerOrgUsersSettingsButtonTitleFont, size: 20.0)

        self.view.addSubview(orgUsersSettingButton)

        self.view.addConstraint(orgUsersSettingButton.topAnchor.constraint(equalTo: orgSettingLabel.bottomAnchor))
        self.view.addConstraint(orgUsersSettingButton.widthAnchor.constraint(equalTo: (orgUsersSettingButton.superview?.widthAnchor)!))
        self.view.addConstraint(orgUsersSettingButton.heightAnchor.constraint(equalToConstant: 35.0))

        orgUsersSettingButton.addTarget(self, action: #selector(SettingsViewController.usersButtonPressed(_:)), for: .touchUpInside)
    }

    func setupLogoutButton() {
        logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        logoutButton.setTitle(NSLocalizedString("settings_vc_logout_button_title", value: "LOG OUT",comment: "Setting VC Logout Button Title"), for: .normal)
        logoutButton.backgroundColor = UIColor(hexString: ProjectCloseColors.settingsViewControllerLogoutButtonBackgroundColor)
        logoutButton.setTitleColor(UIColor(hexString: ProjectCloseColors.settingsViewControllerLogoutButtonTitleColor), for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.settingsViewControllerLogoutButtonTitleFont, size: 20.0)

        self.view.addSubview(logoutButton)

        self.view.addConstraint(logoutButton.bottomAnchor.constraint(equalTo: (logoutButton.superview?.bottomAnchor)!))
        self.view.addConstraint(logoutButton.widthAnchor.constraint(equalTo: (orgUsersSettingButton.superview?.widthAnchor)!))
        self.view.addConstraint(logoutButton.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func usersButtonPressed(_ sender: UIButton) {
        let usersTableViewController = UsersTableViewController()

        self.navigationController?.pushViewController(usersTableViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : SettingsViewController")
    }
    
}
