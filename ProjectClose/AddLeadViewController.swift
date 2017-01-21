//
//  AddLeadViewController.swift
//  ProjectClose
//
//  Created by raj on 20/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class AddLeadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()
        setupLeftBarButton()
    }

    func initTitle() {
        self.title = NSLocalizedString("new_lead_vc_title", value: "New Lead", comment: "New Lead VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(AddUserViewController.backButtonPressed(_:)))
    }


    func backButtonPressed(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : AddLeadViewController")
    }

}
