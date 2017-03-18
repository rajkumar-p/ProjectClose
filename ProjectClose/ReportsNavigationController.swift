//
//  ReportsNavigationController.swift
//  ProjectClose
//
//  Created by raj on 06/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class ReportsNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setTitle()
        setTabBarItemImage(name: ProjectCloseStrings.reportsNavigationControllerReportsImageName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle() {
        self.title = NSLocalizedString("reports_nav_vc_title", value: "Reports",comment: "Reports Nav VC title")
    }

    func setTabBarItemImage(name: String) {
        self.tabBarItem.image = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
