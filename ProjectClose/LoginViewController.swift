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

class LoginViewController: UIViewController {

    let backgroundGradientColors = [UIColor(hexString: ProjectCloseColors.loginViewControllerBackgroundColor1), UIColor(hexString: ProjectCloseColors.loginViewControllerBackgroundColor2)]

    var logoLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()

        setupLogo()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LoginViewController")
    }

}
