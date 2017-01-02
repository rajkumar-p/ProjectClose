//
//  LoginViewController.swift
//  ProjectClose
//
//  Created by raj on 02/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import ChameleonFramework

class LoginViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let backgroundGradientColors = [UIColor(hexString: "#2C3541"), UIColor(hexString: "#353F4E")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    func setupView() {
        self.view.backgroundColor = UIColor(gradientStyle: .radial, withFrame: self.view.bounds, andColors: backgroundGradientColors as! [UIColor])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
