//
//  MainNavigationController.swift
//  ProjectClose
//
//  Created by raj on 07/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
//        ProjectCloseUtilities.styleNavigationBar(navigationBar: self.navigationBar, colorHexString: ProjectCloseColors.loginViewControllerImageOverlayBackgroundColor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : MainNavigationController")
    }
    
}
