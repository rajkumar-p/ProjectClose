//
//  AddUserViewController.swift
//  ProjectClose
//
//  Created by raj on 15/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()
    }

    func initTitle() {
        self.title = NSLocalizedString("add_users_vc_title", value: "Add User", comment: "Add User VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning - AddUserViewController")
    }

}
