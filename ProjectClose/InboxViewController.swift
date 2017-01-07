//
//  InboxViewController.swift
//  ProjectClose
//
//  Created by raj on 06/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        initTitle()
//        ProjectCloseUtilities.styleTabBarItem(tabBarItem: self.tabBarItem, imageName: ProjectCloseStrings.inboxNavigationControllerInboxImageName)
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
        self.title = NSLocalizedString("inbox_vc_title", value: "Inbox", comment: "Inbox VC title")
    }

    func setupView() {
        self.view.backgroundColor = .red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : InboxViewController")
    }
    
}
