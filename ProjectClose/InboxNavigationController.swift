//
//  InboxNavigationController.swift
//  ProjectClose
//
//  Created by raj on 06/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class InboxNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setTabBarItemImage(name: ProjectCloseStrings.inboxNavigationControllerInboxImageName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTabBarItemImage(name: String) {
        self.tabBarItem.image = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTitle()
    }

    func setTitle() {
        self.title = NSLocalizedString("inbox_nav_vc_title", value: "Inbox",comment: "Inbox Nav VC title")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : InboxNavigationController")
    }
    
}
