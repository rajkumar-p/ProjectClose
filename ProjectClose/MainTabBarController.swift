//
//  MainTabBarController.swift
//  ProjectClose
//
//  Created by raj on 05/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    func setupView() {
        self.view.backgroundColor = .green
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning - MainTabBarController")
    }
    
}
