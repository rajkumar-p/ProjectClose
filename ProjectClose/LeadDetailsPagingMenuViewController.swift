//
//  LeadDetailsPagingMenuViewController.swift
//  ProjectClose
//
//  Created by raj on 23/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift
import PagingMenuController

class LeadDetailsPagingMenuViewController: PagingMenuController {
    var realm: Realm!
    var leadResultSet: Results<Lead>!
    var lead: Lead!
    var leadId: String!
    var mainNavigationController: UINavigationController!

    var changeDelegate: ChangeLeadDelegate!

//    override init(options: PagingMenuControllerCustomizable) {
//        super.init(options: options)
//
//        setupAddTaskButton()
//    }

    init(options: PagingMenuControllerCustomizable, leadId: String, mainNavigationController: UINavigationController) {
        self.leadId = leadId
        self.mainNavigationController = mainNavigationController
        super.init(options: options)
//        setupAddTaskButton()
        setupLeftBarButton()
    }

    init(options: PagingMenuControllerCustomizable, leadId: String) {
        self.leadId = leadId
        super.init(options: options)
//        setupAddTaskButton()
        setupLeftBarButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRealm()
        loadLeadDetails(leadId: leadId)
        
        initTitle()
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

    func setupAddTaskButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        rightBarButtonItem.tintColor = UIColor(hexString: ProjectCloseColors.pagingInboxViewControllerAddTaskButtonColor)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(LeadDetailsPagingMenuViewController.backButtonPressed(_:)))
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
//        let _ = self.navigationController?.popViewController(animated: true)
        let _ = self.navigationController?.popToViewController(changeDelegate as! UIViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : OverridenPagingMenuController")
    }

}
