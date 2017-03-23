//
//  OverridenPagingMenuController.swift
//  ProjectClose
//
//  Created by raj on 10/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import PagingMenuController

class OverridenPagingMenuController: PagingMenuController, AddTaskDelegate {

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

//        setupPagingMenuMoveHandler()
    }

    func initTitle() {
        self.title = NSLocalizedString("pagingmenu_vc_title", value: "Inbox",comment: "PagingMenu VC title")
    }

    func setupAddTaskButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(OverridenPagingMenuController.addTaskButtonPressed(_:)))
        rightBarButtonItem.tintColor = UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerAddTaskButtonColor)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func addTaskButtonPressed(_ sender: UIBarButtonItem) {
        let addTaskViewController = AddTaskViewController()
        addTaskViewController.addTaskDelegate = self

        self.navigationController?.pushViewController(addTaskViewController, animated: true)
    }

    func setupPagingMenuMoveHandler() {
        self.onMove = { state in
            switch state {
            case .willMoveController(_, _): break
            case let .didMoveController(menuViewController, _):
                print(menuViewController)
            case .willMoveItem(_, _): break
            case .didMoveItem(_, _): break
            }
        }

//        let leadDetailsPagingMenuViewController = self.childViewControllers.first as! LeadDetailsPagingMenuViewController
//        selectedViewController = leadDetailsPagingMenuViewController.childViewControllers.first?.childViewControllers.first
//
////        let leadStatusTableViewController = leadDetailsPagingMenuViewController.childViewControllers.first?.childViewControllers.last as! LeadStatusTableViewController
////        leadStatusTableViewController.leadId = leadId
//
//        leadDetailsPagingMenuViewController.onMove = { state in
//            switch state {
//            case .willMoveController(_, _): break
//            case let .didMoveController(menuViewController, _):
//                self.selectedViewController = menuViewController
//            case .willMoveItem(_, _): break
//            case .didMoveItem(_, _): break
//            }
//        }
    }

    func didFinishAddingTask(sender: AddTaskViewController) {
//        for viewController in (self.childViewControllers.first?.childViewControllers)! {
//            if viewController is AllInboxTableViewController {
//                let allInboxViewController = viewController as! AllInboxTableViewController
//                allInboxViewController.reloadTableView()
//            } else if viewController is FutureInboxTableViewController {
//                let futureInboxViewController = viewController as! FutureInboxTableViewController
//                futureInboxViewController.reloadTableView()
//            } else if viewController is DoneInboxTableViewController {
//                let doneInboxViewController = viewController as! DoneInboxTableViewController
//                doneInboxViewController.reloadTableView()
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : OverridenPagingMenuController")
    }

}
