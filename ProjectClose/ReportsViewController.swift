//
//  ReportsViewController.swift
//  ProjectClose
//
//  Created by raj on 06/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        initTitle()
//        ProjectCloseUtilities.styleTabBarItem(tabBarItem: self.tabBarItem, imageName: ProjectCloseStrings.reportsNavigationControllerReportsImageName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    func initTitle() {
        self.title = NSLocalizedString("reports_vc_title", value: "Reports", comment: "Reports VC title")
    }

    func setupView() {
        self.view.backgroundColor = .yellow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : ReportsViewController")
    }
    
}
