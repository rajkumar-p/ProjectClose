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
import ChameleonFramework

class LoginViewController: UIViewController, UITextFieldDelegate {

    let backgroundGradientColors = [UIColor(hexString: ProjectCloseColors.loginViewControllerBackgroundColor1), UIColor(hexString: ProjectCloseColors.loginViewControllerBackgroundColor2)]

    var logoLabel: UILabel!

    var emailTextField: UIOffsetUITextField!
    var passwordTextField: UIOffsetUITextField!

    var loginButton: UIButton!
    var forgotPasswordButton: UIButton!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()

        setupLogo()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupForgotPasswordButton()
    }

    func setupView() {
        self.view.backgroundColor = UIColor(gradientStyle: .radial, withFrame: self.view.bounds, andColors: backgroundGradientColors as! [UIColor])
    }

    func setupLogo() {
        logoLabel = UILabel()
        logoLabel.translatesAutoresizingMaskIntoConstraints = false

        logoLabel.font = UIFont(name: ProjectCloseFonts.loginViewControllerLogoFont, size: 36.0)
        logoLabel.text = NSLocalizedString("login_vc_logo_title", value: "Close.io", comment: "Login VC logo title")
        logoLabel.textColor = UIColor(hexString: ProjectCloseColors.loginViewControllerLogoTitleColor)
        logoLabel.textAlignment = .center

        logoLabel.layer.borderWidth = 2.0
        logoLabel.layer.borderColor = UIColor(hexString: ProjectCloseColors.loginViewControllerLogoBorderColor)?.cgColor

        self.view.addSubview(logoLabel)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-60-[logoLabel(>=100)]-60-|", metrics: nil, views: ["logoLabel" : logoLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[logoLabel(==50)]", metrics: nil, views: ["logoLabel" : logoLabel]))
    }

    func setupEmailTextField() {
        emailTextField = UIOffsetUITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textColor = UIColor(hexString: ProjectCloseColors.loginViewControllerEmailTextFieldColor)

        emailTextField.font = UIFont(name: ProjectCloseFonts.loginViewControllerEmailTextFieldFont, size: 22.0)
        emailTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("login_vc_email_placeholder", value: "email", comment: "Login VC email placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.loginViewControllerEmailTextFieldPlaceholderColor)!,
                NSFontAttributeName : UIFont(name: ProjectCloseFonts.loginViewControllerEmailTextFieldPlaceholderFont, size: 20.0)!])
        emailTextField.backgroundColor = UIColor(hexString: ProjectCloseColors.loginViewControllerEmailTextFieldBackgroundColor)
        emailTextField.alpha = 0.75

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

        passwordTextField.font = UIFont(name: ProjectCloseFonts.loginViewControllerPasswordTextFieldFont, size: 22.0)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("login_vc_password_placeholder", value: "password", comment: "Login VC password placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.loginViewControllerPasswordTextFieldPlaceholderColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.loginViewControllerPasswordTextFieldPlaceholderFont, size: 20.0)!])
        passwordTextField.backgroundColor = UIColor(hexString: ProjectCloseColors.loginViewControllerPasswordTextFieldBackgroundColor)
        passwordTextField.alpha = 0.75

        passwordTextField.delegate = self

        self.view.addSubview(passwordTextField)

        self.view.addConstraint(passwordTextField.widthAnchor.constraint(equalTo: (passwordTextField.superview?.widthAnchor)!))
        self.view.addConstraint(passwordTextField.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2.0))
    }

    func setupLoginButton() {
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        loginButton.setTitle(NSLocalizedString("login_vc_login_button_title", value: "LOG IN",comment: "Login VC login button title"), for: .normal)
        loginButton.setTitleColor(UIColor(hexString: ProjectCloseColors.loginViewControllerLoginButtonTitleColor), for: .normal)
        loginButton.backgroundColor = UIColor(hexString: ProjectCloseColors.loginViewControllerLoginButtonBackgroundColor)

        loginButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.loginViewControllerLoginButtonTitleFont, size: 25.0)

        self.view.addSubview(loginButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[loginButton(>=50)]-100-|", metrics: nil, views: ["loginButton" : loginButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[passwordTextField]-75-[loginButton(==40)]", metrics: nil, views: ["loginButton" : loginButton, "passwordTextField" : passwordTextField]))
    }

    func setupForgotPasswordButton() {
        forgotPasswordButton = UIButton()
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false

        forgotPasswordButton.sizeToFit()
        forgotPasswordButton.setTitle(NSLocalizedString("login_vc_forgot_password_button_title", value: "Forgot Password?",comment: "Login VC forgot password button title"), for: .normal)
        forgotPasswordButton.setTitleColor(UIColor(hexString: ProjectCloseColors.loginViewControllerForgotPasswordButtonTitleColor), for: .normal)

        forgotPasswordButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.loginViewControllerForgotPasswordButtonTitleFont, size: 18.0)

        self.view.addSubview(forgotPasswordButton)

        self.view.addConstraint(forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20.0))
        self.view.addConstraint(forgotPasswordButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LoginViewController")
    }

}
