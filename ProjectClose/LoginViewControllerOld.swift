//
//  LoginViewController.swift
//  ProjectClose
//
//  Created by raj on 02/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import PagingMenuController
import ChameleonFramework

class LoginViewControllerOld: UIViewController, UITextFieldDelegate {

    var backgroundImageView: UIImageView!
    var backgroundImageOverlayView: UIView!

    var logoImageView: UIView!
    var logoLabel: UILabel!

    var emailTextField: UIOffsetUITextField!
    var passwordTextField: UIOffsetUITextField!

    var loginButton: UIButton!
    var forgotPasswordButton: UIButton!

    var signupButton: UIButton!
    var helpButton: UIButton!

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        setupView()

        setupBackgroundImage()
        setupBackgroundImageOverlayView()

        setupLogoImageView()
        setupLogoLabel()

        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupForgotPasswordButton()

        setupSignupButton()
        setupHelpButton()
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupBackgroundImage() {
        backgroundImageView = UIImageView(image: UIImage(named: ProjectCloseStrings.loginViewControllerBackgroundImageName))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        backgroundImageView.contentMode = .scaleAspectFill

        self.view.addSubview(backgroundImageView)

        self.view.addConstraint(backgroundImageView.heightAnchor.constraint(equalTo: (backgroundImageView.superview?.heightAnchor)!))
        self.view.addConstraint(backgroundImageView.widthAnchor.constraint(equalTo: (backgroundImageView.superview?.widthAnchor)!))
    }

    func setupBackgroundImageOverlayView() {
        backgroundImageOverlayView = UIView()
        backgroundImageOverlayView.translatesAutoresizingMaskIntoConstraints = false

        backgroundImageOverlayView.backgroundColor = UIColor(hexString: ProjectCloseColors.loginViewControllerImageOverlayBackgroundColor, withAlpha: 0.4)

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

        logoLabel.font = UIFont(name: ProjectCloseFonts.loginViewControllerLogoFont, size: 36.0)
        logoLabel.text = NSLocalizedString("login_vc_logo_title", value: "Close.io", comment: "Login VC Logo Title")
        logoLabel.textColor = UIColor(hexString: ProjectCloseColors.loginViewControllerLogoTitleColor)
        logoLabel.textAlignment = .center

        logoLabel.layer.borderWidth = 4.0
        logoLabel.layer.borderColor = UIColor(hexString: ProjectCloseColors.loginViewControllerLogoBorderColor)?.cgColor

        self.view.addSubview(logoLabel)

        self.view.addConstraint(logoLabel.widthAnchor.constraint(equalToConstant: 200.0))
        self.view.addConstraint(logoLabel.heightAnchor.constraint(equalToConstant: 50.0))
        self.view.addConstraint(logoLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 20.0))
        self.view.addConstraint(logoLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor))
    }

    func setupEmailTextField() {
        emailTextField = UIOffsetUITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textColor = UIColor(hexString: ProjectCloseColors.loginViewControllerEmailTextFieldColor)
        emailTextField.tintColor = UIColor(hexString: ProjectCloseColors.loginViewControllerTextFieldTintColor)

        emailTextField.font = UIFont(name: ProjectCloseFonts.loginViewControllerEmailTextFieldFont, size: 22.0)
        emailTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("login_vc_email_placeholder", value: "email", comment: "Login VC Email Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.loginViewControllerEmailTextFieldPlaceholderColor)!,
                NSFontAttributeName : UIFont(name: ProjectCloseFonts.loginViewControllerEmailTextFieldPlaceholderFont, size: 20.0)!])
        emailTextField.backgroundColor = UIColor(hexString: ProjectCloseColors.loginViewControllerEmailTextFieldBackgroundColor)

        emailTextField.delegate = self

        self.view.addSubview(emailTextField)

        self.view.addConstraint(emailTextField.widthAnchor.constraint(equalTo: (emailTextField.superview?.widthAnchor)!))
        self.view.addConstraint(emailTextField.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(emailTextField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 100.0))
    }

    func setupPasswordTextField() {
        passwordTextField = UIOffsetUITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = UIColor(hexString: ProjectCloseColors.loginViewControllerPasswordTextFieldColor)
        passwordTextField.tintColor = UIColor(hexString: ProjectCloseColors.loginViewControllerTextFieldTintColor)

        passwordTextField.font = UIFont(name: ProjectCloseFonts.loginViewControllerPasswordTextFieldFont, size: 22.0)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("login_vc_password_placeholder", value: "password", comment: "Login VC Password Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.loginViewControllerPasswordTextFieldPlaceholderColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.loginViewControllerPasswordTextFieldPlaceholderFont, size: 20.0)!])
        passwordTextField.backgroundColor = UIColor(hexString: ProjectCloseColors.loginViewControllerPasswordTextFieldBackgroundColor)

        passwordTextField.delegate = self

        self.view.addSubview(passwordTextField)

        self.view.addConstraint(passwordTextField.widthAnchor.constraint(equalTo: (passwordTextField.superview?.widthAnchor)!))
        self.view.addConstraint(passwordTextField.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2.0))
    }

    func setupLoginButton() {
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        loginButton.setTitle(NSLocalizedString("login_vc_login_button_title", value: "LOG IN",comment: "Login VC Login Button Title"), for: .normal)
        loginButton.setTitleColor(UIColor(hexString: ProjectCloseColors.loginViewControllerLoginButtonTitleColor), for: .normal)
        loginButton.backgroundColor = UIColor(hexString: ProjectCloseColors.loginViewControllerLoginButtonBackgroundColor)

        loginButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.loginViewControllerLoginButtonTitleFont, size: 25.0)

        self.view.addSubview(loginButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[loginButton(>=50)]-100-|", metrics: nil, views: ["loginButton" : loginButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[passwordTextField]-75-[loginButton(==40)]", metrics: nil, views: ["loginButton" : loginButton, "passwordTextField" : passwordTextField]))

        loginButton.addTarget(self, action: #selector(LoginViewController.loginButtonPressed(_:)), for: .touchUpInside)
    }

    func setupForgotPasswordButton() {
        forgotPasswordButton = UIButton()
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false

        forgotPasswordButton.sizeToFit()
        forgotPasswordButton.setTitle(NSLocalizedString("login_vc_forgot_password_button_title", value: "Forgot Password?",comment: "Login VC Forgot Password Button Title"), for: .normal)
        forgotPasswordButton.setTitleColor(UIColor(hexString: ProjectCloseColors.loginViewControllerForgotPasswordButtonTitleColor), for: .normal)

        forgotPasswordButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.loginViewControllerForgotPasswordButtonTitleFont, size: 18.0)

        self.view.addSubview(forgotPasswordButton)

        self.view.addConstraint(forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20.0))
        self.view.addConstraint(forgotPasswordButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor))
    }

    func setupSignupButton() {
        signupButton = UIButton()
        signupButton.translatesAutoresizingMaskIntoConstraints = false

        signupButton.sizeToFit()
        signupButton.setTitle(NSLocalizedString("login_vc_signup_button_title", value: "SIGN UP", comment: "Login VC Signup Button Title"), for: .normal)
        signupButton.setTitleColor(UIColor(hexString: ProjectCloseColors.loginViewControllerSignupButtonTitleColor), for: .normal)

        signupButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.loginViewControllerSignupButtonTitleFont, size: 18.0)

        self.view.addSubview(signupButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-9-[signupButton]", metrics: nil, views: ["signupButton" : signupButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[signupButton]-5-|", metrics: nil, views: ["signupButton" : signupButton]))
    }

    func setupHelpButton() {
        helpButton = UIButton()
        helpButton.translatesAutoresizingMaskIntoConstraints = false

        helpButton.sizeToFit()
        helpButton.setTitle(NSLocalizedString("login_vc_help_button_title", value: "HELP", comment: "Login VC Help Button Title"), for: .normal)
        helpButton.setTitleColor(UIColor(hexString: ProjectCloseColors.loginViewControllerHelpButtonTitleColor), for: .normal)

        helpButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.loginViewControllerHelpButtonTitleFont, size: 18.0)

        self.view.addSubview(helpButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[helpButton]-9-|", metrics: nil, views: ["helpButton" : helpButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[helpButton]-5-|", metrics: nil, views: ["helpButton" : helpButton]))
    }

    fileprivate struct PageMenuItemAll: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("pagingmenu_vc_all_inbox_menu_title", value: "ALL", comment: "Paging Menu VC All Inbox Menu Title"),
                    color: UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerPageMenuTitleColor)!,
                    selectedColor: UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerSelectedPageMenuTitleColor)!,
                    font: UIFont(name: ProjectCloseFonts.pagingInboxViewControllerPageMenuTitleFont, size: 18.0)!,
                    selectedFont: UIFont(name: ProjectCloseFonts.pagingInboxViewControllerSelectedPageMenuTitleFont, size: 18.0)!
            ))
        }

        var horizontalMargin: CGFloat {
            return 5.0
        }
    }

    fileprivate struct PageMenuItemFuture: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("pagingmenu_vc_future_inbox_menu_title", value: "FUTURE", comment: "Paging Menu VC Future Inbox Menu Title"),
                    color: UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerPageMenuTitleColor)!,
                    selectedColor: UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerSelectedPageMenuTitleColor)!,
                    font: UIFont(name: ProjectCloseFonts.pagingInboxViewControllerPageMenuTitleFont, size: 18.0)!,
                    selectedFont: UIFont(name: ProjectCloseFonts.pagingInboxViewControllerSelectedPageMenuTitleFont, size: 18.0)!
            ))
        }

        var horizontalMargin: CGFloat {
            return 5.0
        }
    }

    fileprivate struct PageMenuItemDone: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("pagingmenu_vc_done_inbox_menu_title", value: "DONE", comment: "Paging Menu VC Done Inbox Menu Title"),
                    color: UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerPageMenuTitleColor)!,
                    selectedColor: UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerSelectedPageMenuTitleColor)!,
                    font: UIFont(name: ProjectCloseFonts.pagingInboxViewControllerPageMenuTitleFont, size: 18.0)!,
                    selectedFont: UIFont(name: ProjectCloseFonts.pagingInboxViewControllerSelectedPageMenuTitleFont, size: 18.0)!
            ))
        }

        var horizontalMargin: CGFloat {
            return 5.0
        }
    }

    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
//            return .standard(widthMode: .flexible, centerItem: false, scrollingMode: .pagingEnabled)
        }

        var focusMode: MenuFocusMode {
            return .underline(height: 3.0, color: UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerSelectedPageMenuUnderlineColor)!, horizontalPadding: 10.0, verticalPadding: 0.0)
        }

        var itemsOptions: [MenuItemViewCustomizable] {
            return [PageMenuItemAll(), PageMenuItemFuture(), PageMenuItemDone()]
        }
    }

    fileprivate struct PagingMenuOptions: PagingMenuControllerCustomizable {
        let allInboxTableViewController = AllInboxTableViewController()
        let futureInboxTableViewController = FutureInboxTableViewController()
        let doneInboxTableViewController = DoneInboxTableViewController()

        var componentType: ComponentType {
            return .all(menuOptions: MenuOptions(), pagingControllers: [allInboxTableViewController, futureInboxTableViewController, doneInboxTableViewController])
        }

        var lazyLoadingPage: LazyLoadingPage {
            return .one
        }

        var isScrollEnabled: Bool {
            return false
        }
    }

    func loginButtonPressed(_ sender: UIButton) {
        let pagingInboxMenuController = OverridenPagingMenuController(options: PagingMenuOptions())

        let opportunitiesTableViewController = OpportunitiesTableViewController()
        let leadsTableViewController = LeadsTableViewController()
        let reportsTableViewController = ReportsTableViewController()
        let settingsTableViewController = SettingsTableViewController()

        let inboxNavigationController = InboxNavigationController()
        let opportunitiesNavigationController = OpportunitiesNavigationController()
        let leadsNavigationController = LeadsNavigationController()
        let reportsNavigationController = ReportsNavigationController()
        let settingsNavigationController = SettingsNavigationController()

        inboxNavigationController.pushViewController(pagingInboxMenuController, animated: false)
        opportunitiesNavigationController.pushViewController(opportunitiesTableViewController, animated: false)
        leadsNavigationController.pushViewController(leadsTableViewController, animated: false)
        reportsNavigationController.pushViewController(reportsTableViewController, animated: false)
        settingsNavigationController.pushViewController(settingsTableViewController, animated: false)

        let mainTabBarController = MainTabBarController()
        mainTabBarController.viewControllers = [inboxNavigationController, opportunitiesNavigationController, leadsNavigationController, reportsNavigationController, settingsNavigationController]

        self.present(mainTabBarController, animated: true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LoginViewController")
    }

}
