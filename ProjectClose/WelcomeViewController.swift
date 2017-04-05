//
//  WelcomeViewController.swift
//  ProjectClose
//
//  Created by raj on 04/04/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class WelcomeViewController: UIViewController {
    var backgroundImageView: UIImageView!
    var backgroundImageOverlayView: UIView!

    var logoImageView: UIView!
    var logoLabel: UILabel!

    var hustleLabel: UILabel!
    var closeMoreLabel: UILabel!
    var dealsLabel: UILabel!

    var registerView: UIView!
    var loginView: UIView!

    var newUserLabel: UILabel!
    var existingUserLabel: UILabel!

    var registerButton: UIButton!
    var loginButton: UIButton!

    var seperatorView: UIView!
    var orLabel: UILabel!

    var websiteButton: UIButton!
    var helpButton: UIButton!

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        
        setupBackgroundImage()
        setupBackgroundImageOverlayView()

        setupLogoImageView()
        setupLogoLabel()

        setupHustleLabel()
        setupCloseMoreLabel()
        setupDealsLabel()

        setupRegisterView()
        setupLoginView()

        setupNewUserLabel()
        setupExistingUserLabel()

        setupRegisterButton()
        setupLoginButton()

        setupSeperatorView()
        setupOrLabel()
        
        setupWebsiteButton()
        setupHelpButton()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupBackgroundImage() {
        backgroundImageView = UIImageView(image: UIImage(named: ProjectCloseStrings.welcomeViewControllerBackgroundImageName))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        backgroundImageView.contentMode = .scaleAspectFill

        self.view.addSubview(backgroundImageView)

        self.view.addConstraint(backgroundImageView.heightAnchor.constraint(equalTo: (backgroundImageView.superview?.heightAnchor)!))
        self.view.addConstraint(backgroundImageView.widthAnchor.constraint(equalTo: (backgroundImageView.superview?.widthAnchor)!))
    }

    func setupBackgroundImageOverlayView() {
        backgroundImageOverlayView = UIView()
        backgroundImageOverlayView.translatesAutoresizingMaskIntoConstraints = false

        backgroundImageOverlayView.backgroundColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerImageOverlayBackgroundColor, withAlpha: 0.4)

        backgroundImageView.addSubview(backgroundImageOverlayView)

        backgroundImageView.addConstraint(backgroundImageOverlayView.heightAnchor.constraint(equalTo: (backgroundImageOverlayView.superview?.heightAnchor)!))
        backgroundImageView.addConstraint(backgroundImageOverlayView.widthAnchor.constraint(equalTo: (backgroundImageOverlayView.superview?.widthAnchor)!))
    }

    func setupLogoImageView() {
        logoImageView = UIImageView(image: UIImage(named: ProjectCloseStrings.welcomeViewControllerLogoImageName))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        logoImageView.contentMode = .scaleAspectFill

        self.view.addSubview(logoImageView)

        self.view.addConstraint(logoImageView.heightAnchor.constraint(equalToConstant: 50.0))
        self.view.addConstraint(logoImageView.widthAnchor.constraint(equalToConstant: 50.0))
        self.view.addConstraint(logoImageView.leftAnchor.constraint(equalTo: (logoImageView.superview?.leftAnchor)!, constant: 20.0))
        self.view.addConstraint(logoImageView.topAnchor.constraint(equalTo: (logoImageView.superview?.topAnchor)!, constant: 50.0))
    }

    func setupLogoLabel() {
        logoLabel = UILabel()
        logoLabel.translatesAutoresizingMaskIntoConstraints = false

        logoLabel.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerLogoFont, size: 36.0)
        logoLabel.text = NSLocalizedString("welcome_vc_logo_title", value: "Close.io", comment: "Welcome VC logo title")
        logoLabel.textColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerLogoTitleColor)
        logoLabel.textAlignment = .center

        logoLabel.layer.borderWidth = 4.0
        logoLabel.layer.borderColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerLogoBorderColor)?.cgColor

        self.view.addSubview(logoLabel)

        self.view.addConstraint(logoLabel.widthAnchor.constraint(equalToConstant: 200.0))
        self.view.addConstraint(logoLabel.heightAnchor.constraint(equalToConstant: 50.0))
        self.view.addConstraint(logoLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 20.0))
        self.view.addConstraint(logoLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor))
    }

    func setupHustleLabel() {
        hustleLabel = UILabel()
        hustleLabel.translatesAutoresizingMaskIntoConstraints = false

        hustleLabel.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerHustleTitleFont, size: 70.0)
        hustleLabel.text = NSLocalizedString("welcome_vc_hustle_title", value: "hustle.", comment: "Welcome VC Hustle Title")
        hustleLabel.textColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerHustleTitleColor)
        hustleLabel.textAlignment = .left
        hustleLabel.sizeToFit()

        self.view.addSubview(hustleLabel)

        self.view.addConstraint(hustleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50.0))
        self.view.addConstraint(hustleLabel.leftAnchor.constraint(equalTo: (hustleLabel.superview?.leftAnchor)!, constant: 20.0))
    }

    func setupCloseMoreLabel() {
        closeMoreLabel = UILabel()
        closeMoreLabel.translatesAutoresizingMaskIntoConstraints = false

        closeMoreLabel.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerCloseMoreTitleFont, size: 70.0)
        closeMoreLabel.text = NSLocalizedString("welcome_vc_close_more_title", value: "close more", comment: "Welcome VC Close More Title")
        closeMoreLabel.textColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerCloseMoreTitleColor)
        closeMoreLabel.textAlignment = .left
        closeMoreLabel.sizeToFit()

        self.view.addSubview(closeMoreLabel)

        self.view.addConstraint(closeMoreLabel.topAnchor.constraint(equalTo: hustleLabel.bottomAnchor, constant: 10.0))
        self.view.addConstraint(closeMoreLabel.leftAnchor.constraint(equalTo: (closeMoreLabel.superview?.leftAnchor)!, constant: 20.0))
    }

    func setupDealsLabel() {
        dealsLabel = UILabel()
        dealsLabel.translatesAutoresizingMaskIntoConstraints = false

        dealsLabel.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerSalesTitleFont, size: 70.0)
        dealsLabel.text = NSLocalizedString("welcome_vc_deals_title", value: "deals.", comment: "Welcome VC Deals Title")
        dealsLabel.textColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerSalesTitleColor)
        dealsLabel.textAlignment = .left
        dealsLabel.sizeToFit()

        self.view.addSubview(dealsLabel)

        self.view.addConstraint(dealsLabel.topAnchor.constraint(equalTo: closeMoreLabel.bottomAnchor, constant: 10.0))
        self.view.addConstraint(dealsLabel.leftAnchor.constraint(equalTo: (dealsLabel.superview?.leftAnchor)!, constant: 20.0))
    }

    func setupRegisterView() {
        registerView = UIView()
        registerView.translatesAutoresizingMaskIntoConstraints = false

        registerView.backgroundColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerRegisterViewColor)

        self.view.addSubview(registerView)

        self.view.addConstraint(registerView.widthAnchor.constraint(equalTo: (registerView.superview?.widthAnchor)!, multiplier: 0.50))
        self.view.addConstraint(registerView.heightAnchor.constraint(equalToConstant: 60.0))
        self.view.addConstraint(registerView.topAnchor.constraint(equalTo: dealsLabel.bottomAnchor, constant: 50.0))
        self.view.addConstraint(registerView.leftAnchor.constraint(equalTo: (registerView.superview?.leftAnchor)!))
    }

    func setupLoginView() {
        loginView = UIView()
        loginView.translatesAutoresizingMaskIntoConstraints = false

        loginView.backgroundColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerLoginViewColor)

        self.view.addSubview(loginView)

        self.view.addConstraint(loginView.widthAnchor.constraint(equalTo: (loginView.superview?.widthAnchor)!, multiplier: 0.50))
        self.view.addConstraint(loginView.heightAnchor.constraint(equalToConstant: 60.0))
        self.view.addConstraint(loginView.topAnchor.constraint(equalTo: dealsLabel.bottomAnchor, constant: 50.0))
        self.view.addConstraint(loginView.rightAnchor.constraint(equalTo: (loginView.superview?.rightAnchor)!))
    }

    func setupNewUserLabel() {
        newUserLabel = UILabel()
        newUserLabel.translatesAutoresizingMaskIntoConstraints = false

        newUserLabel.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerNewUserTitleFont, size: 15.0)
        newUserLabel.text = NSLocalizedString("welcome_vc_new_user_title", value: "New User?", comment: "Welcome VC New User Title")
        newUserLabel.textColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerNewUserTitleColor)
        newUserLabel.textAlignment = .left
        newUserLabel.sizeToFit()

        registerView.addSubview(newUserLabel)

        registerView.addConstraint(newUserLabel.leftAnchor.constraint(equalTo: (newUserLabel.superview?.leftAnchor)!, constant: 5.0))
        registerView.addConstraint(newUserLabel.topAnchor.constraint(equalTo: (newUserLabel.superview?.topAnchor)!, constant: 5.0))
    }

    func setupExistingUserLabel() {
        existingUserLabel = UILabel()
        existingUserLabel.translatesAutoresizingMaskIntoConstraints = false

        existingUserLabel.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerExistingUserTitleFont, size: 15.0)
        existingUserLabel.text = NSLocalizedString("welcome_vc_existing_user_title", value: "Existing User?", comment: "Welcome VC Existing User Title")
        existingUserLabel.textColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerExistingUserTitleColor)
        existingUserLabel.textAlignment = .right
        existingUserLabel.sizeToFit()

        loginView.addSubview(existingUserLabel)

        loginView.addConstraint(existingUserLabel.rightAnchor.constraint(equalTo: (existingUserLabel.superview?.rightAnchor)!, constant: -5.0))
        loginView.addConstraint(existingUserLabel.topAnchor.constraint(equalTo: (existingUserLabel.superview?.topAnchor)!, constant: 5.0))
    }

    func setupRegisterButton() {
        registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false

        registerButton.setTitle(NSLocalizedString("welcome_vc_register_title", value: "Register", comment: "Welcome VC Register Title"), for: .normal)
        registerButton.setTitleColor(UIColor(hexString: ProjectCloseColors.welcomeViewControllerRegisterTitleColor), for: .normal)
        registerButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerRegisterTitleFont, size: 30.0)
        registerButton.titleLabel?.textAlignment = .left
        registerButton.sizeToFit()

        registerButton.addTarget(self, action: #selector(WelcomeViewController.registerButtonPressed(_:)), for: .touchUpInside)

        registerView.addSubview(registerButton)

        registerView.addConstraint(registerButton.heightAnchor.constraint(equalToConstant: 30.0))
        registerView.addConstraint(registerButton.leftAnchor.constraint(equalTo: (registerButton.superview?.leftAnchor)!, constant: 5.0))
        registerView.addConstraint(registerButton.topAnchor.constraint(equalTo: newUserLabel.bottomAnchor, constant: 2.0))
    }

    func setupLoginButton() {
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        loginButton.setTitle(NSLocalizedString("welcome_vc_login_title", value: "Login", comment: "Welcome VC Login Title"), for: .normal)
        loginButton.setTitleColor(UIColor(hexString: ProjectCloseColors.welcomeViewControllerLoginTitleColor), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerLoginTitleFont, size: 30.0)
        loginButton.titleLabel?.textAlignment = .left
        loginButton.sizeToFit()

        loginButton.addTarget(self, action: #selector(WelcomeViewController.loginButtonPressed(_:)), for: .touchUpInside)

        loginView.addSubview(loginButton)

        loginView.addConstraint(loginButton.heightAnchor.constraint(equalToConstant: 30.0))
        loginView.addConstraint(loginButton.rightAnchor.constraint(equalTo: (loginButton.superview?.rightAnchor)!, constant: -5.0))
        loginView.addConstraint(loginButton.topAnchor.constraint(equalTo: existingUserLabel.bottomAnchor, constant: 2.0))
    }

    func setupSeperatorView() {
        seperatorView = UIView()
        seperatorView.translatesAutoresizingMaskIntoConstraints = false

        seperatorView.backgroundColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerSeperatorViewColor)

        self.view.addSubview(seperatorView)

        self.view.addConstraint(seperatorView.heightAnchor.constraint(equalToConstant: 60.0))
        self.view.addConstraint(seperatorView.widthAnchor.constraint(equalToConstant: 1.0))
        self.view.addConstraint(seperatorView.topAnchor.constraint(equalTo: registerView.topAnchor))
        self.view.addConstraint(seperatorView.leftAnchor.constraint(equalTo: registerView.rightAnchor))
    }

    func setupOrLabel() {
        orLabel = UILabel()
        orLabel.translatesAutoresizingMaskIntoConstraints = false

        orLabel.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerOrTitleFont, size: 20.0)
        orLabel.text = NSLocalizedString("welcome_vc_or_title", value: "or", comment: "Welcome VC Or Title")
        orLabel.textColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerOrTitleColor)
        orLabel.backgroundColor = UIColor(hexString: ProjectCloseColors.welcomeViewControllerOrBackgroundColor)
        orLabel.textAlignment = .center

        orLabel.layer.cornerRadius = 40.0 / 2.0
        orLabel.clipsToBounds = true

        self.view.addSubview(orLabel)

        self.view.addConstraint(orLabel.widthAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(orLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(orLabel.centerXAnchor.constraint(equalTo: registerView.rightAnchor))
        self.view.addConstraint(orLabel.centerYAnchor.constraint(equalTo: registerView.centerYAnchor))
    }

    func setupWebsiteButton() {
        websiteButton = UIButton()
        websiteButton.translatesAutoresizingMaskIntoConstraints = false

        websiteButton.sizeToFit()
        websiteButton.setTitle(NSLocalizedString("welcome_vc_website_button_title", value: "WEBSITE", comment: "Welcome VC Website Button Title"), for: .normal)
        websiteButton.setTitleColor(UIColor(hexString: ProjectCloseColors.welcomeViewControllerWebsiteTitleColor), for: .normal)

        websiteButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerWebsiteTitleFont, size: 18.0)

        self.view.addSubview(websiteButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-9-[websiteButton]", metrics: nil, views: ["websiteButton" : websiteButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[websiteButton]-5-|", metrics: nil, views: ["websiteButton" : websiteButton]))
    }

    func setupHelpButton() {
        helpButton = UIButton()
        helpButton.translatesAutoresizingMaskIntoConstraints = false

        helpButton.sizeToFit()
        helpButton.setTitle(NSLocalizedString("welcome_vc_help_button_title", value: "HELP", comment: "Welcome VC Help Button Title"), for: .normal)
        helpButton.setTitleColor(UIColor(hexString: ProjectCloseColors.welcomeViewControllerHelpTitleColor), for: .normal)

        helpButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.welcomeViewControllerHelpTitleFont, size: 18.0)

        self.view.addSubview(helpButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[helpButton]-9-|", metrics: nil, views: ["helpButton" : helpButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[helpButton]-5-|", metrics: nil, views: ["helpButton" : helpButton]))
    }

    func registerButtonPressed(_ sender: UIButton) {
    }

    func loginButtonPressed(_ sender: UIButton) {
        let loginViewController = LoginViewController()

        self.present(loginViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : WelcomeViewController")
    }

}
