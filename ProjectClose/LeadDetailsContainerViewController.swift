//
//  LeadDetailsContainerViewController.swift
//  ProjectClose
//
//  Created by raj on 31/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class LeadDetailsContainerViewController: UIViewController {
    var realm: Realm!
    var leadResultSet: Results<Lead>!
    var lead: Lead!
    var leadId: String!

    var selectedViewController: UIViewController!

    var changeDelegate: ChangeLeadDelegate!

//    init() {
//        super.init(nibName: nil, bundle: nil)
//
//        setupAddButton()
//        setupLeftBarButton()
//    }

    init(leadId: String) {
        super.init(nibName: nil, bundle: nil)

        self.leadId = leadId
        setupAddButton()
        setupLeftBarButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()

        setupPagingMenuMoveHandler()
        setupRealm()
        loadLeadDetails(leadId: leadId)

        initTitle()
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadLeadDetails(leadId: String) {
        lead = realm.object(ofType: Lead.self, forPrimaryKey: leadId)
    }

    func initTitle() {
        self.title = lead.companyName
    }

    func setupAddButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonPressed(_:)))
        rightBarButtonItem.tintColor = UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerAddTaskButtonColor)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupPagingMenuMoveHandler() {
        let leadDetailsPagingMenuViewController = self.childViewControllers.first as! LeadDetailsPagingMenuViewController
        selectedViewController = leadDetailsPagingMenuViewController.childViewControllers.first?.childViewControllers.first
        leadDetailsPagingMenuViewController.onMove = { state in
            switch state {
            case .willMoveController(_, _): break
            case let .didMoveController(menuViewController, _):
                self.selectedViewController = menuViewController
            case .willMoveItem(_, _): break
            case .didMoveItem(_, _): break
            }
        }
    }

    func addButtonPressed(_ sender: UIBarButtonItem) {
        if selectedViewController is LeadTasksTableViewController {
            let addLeadTaskViewController = AddLeadTaskViewController()
            addLeadTaskViewController.leadId = leadId
            addLeadTaskViewController.addLeadTaskDelegate = selectedViewController as! LeadTasksTableViewController
            self.navigationController?.pushViewController(addLeadTaskViewController, animated: true)
        }
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(LeadDetailsContainerViewController.backButtonPressed(_:)))
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        changeDelegate.didChangeLead(sender: self)
        let _ = self.navigationController?.popToViewController(changeDelegate as! UIViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : LeadDetailsContainerViewController")
    }
    
}
