//
//  OverridenPagingMenuController.swift
//  ProjectClose
//
//  Created by raj on 10/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import PagingMenuController

class OverridenPagingMenuController: PagingMenuController {

    override init(options: PagingMenuControllerCustomizable) {
        super.init(options: options)

        setupAddTaskButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
    }

    func initTitle() {
        self.title = NSLocalizedString("pagingmenu_vc_title", value: "Inbox",comment: "PagingMenu VC title")
    }

    func setupAddTaskButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        rightBarButtonItem.tintColor = UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerAddTaskButtonColor)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : OverridenPagingMenuController")
    }

}
