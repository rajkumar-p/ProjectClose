//
//  AddLeadTaskViewController.swift
//  ProjectClose
//
//  Created by raj on 01/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class AddLeadTaskViewController: UIViewController, UITextFieldDelegate, UserChoosenDelegate {
    var realm: Realm!

    var taskDescriptionLabel: UILabel!
    var taskDescriptionTextField: UIOffsetUITextField!

    var assignedToLabel: UILabel!
    var assignedToUserLabel: UILabel!

    var expiryDateLabel: UILabel!
    var expiryDateTextField: UIOffsetUITextField!

    var addLeadTaskButton: UIButton!
    
    var currentUserEmail = "raj@diskodev.com"
    var selectedUser: User!
    var leadId: String!

    var addLeadTaskDelegate: AddLeadTaskDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()
        setupLeftBarButton()
        
        setupRealm()
        loadCurrentUser(currentUserEmail: currentUserEmail)

        setupTaskDescriptionLabel()
        setupTaskDescriptionTextField()

        setupExpiryDateLabel()
        setupExpiryDateTextField()

        setupAssignedToLabel()
        setupAssignedToUserLabel()

        setupAddLeadTaskButton()
    }

    func initTitle() {
        self.title = NSLocalizedString("add_lead_task_vc_title", value: "Add Task", comment: "Add Lead Task VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(AddLeadTaskViewController.backButtonPressed(_:)))
    }
    
    func setupRealm() {
        realm = try! Realm()
    }
    
    func loadCurrentUser(currentUserEmail: String) {
        selectedUser = realm.object(ofType: User.self, forPrimaryKey: currentUserEmail)
    }

    func setupTaskDescriptionLabel() {
        taskDescriptionLabel = UILabel()
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        taskDescriptionLabel.text = NSLocalizedString("add_lead_task_vc_company_name_label_title", value: " Task Description",comment: "Add Lead Task VC Company Name Label Title")
        taskDescriptionLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerTaskDescriptionTitleColor)
        taskDescriptionLabel.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerTaskDescriptionFont, size: 20.0)
        taskDescriptionLabel.sizeToFit()

        self.view.addSubview(taskDescriptionLabel)

        self.view.addConstraint(taskDescriptionLabel.topAnchor.constraint(equalTo: (taskDescriptionLabel.superview?.topAnchor)!, constant: 50.0))
        self.view.addConstraint(taskDescriptionLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupTaskDescriptionTextField() {
        taskDescriptionTextField = UIOffsetUITextField()
        taskDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false

        taskDescriptionTextField.keyboardType = .asciiCapable
        taskDescriptionTextField.autocapitalizationType = .words
        taskDescriptionTextField.autocorrectionType = .no
        taskDescriptionTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerTaskDescriptionTextFieldTitleColor)
        taskDescriptionTextField.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerTaskDescriptionFont, size: 20.0)
        taskDescriptionTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_task_vc_company_name_placeholder", value: "e.g. Call Brady", comment: "Add Lead Task VC Company Name Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerTaskDescriptionTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        taskDescriptionTextField.delegate = self

        self.view.addSubview(taskDescriptionTextField)

        self.view.addConstraint(taskDescriptionTextField.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(taskDescriptionTextField.widthAnchor.constraint(equalTo: (taskDescriptionTextField.superview?.widthAnchor)!))
        self.view.addConstraint(taskDescriptionTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func setupExpiryDateLabel() {
        expiryDateLabel = UILabel()
        expiryDateLabel.translatesAutoresizingMaskIntoConstraints = false

        expiryDateLabel.text = NSLocalizedString("add_lead_task_vc_expiry_date_label_title", value: " Expiry Date",comment: "Add Lead Task VC Expiry Date Label Title")
        expiryDateLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerExpiryDateTitleColor)
        expiryDateLabel.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerExpiryDateFont, size: 20.0)
        expiryDateLabel.sizeToFit()

        self.view.addSubview(expiryDateLabel)

        self.view.addConstraint(expiryDateLabel.topAnchor.constraint(equalTo: taskDescriptionTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(expiryDateLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupExpiryDateTextField() {
        expiryDateTextField = UIOffsetUITextField()
        expiryDateTextField.translatesAutoresizingMaskIntoConstraints = false

        expiryDateTextField.keyboardType = .asciiCapable
        expiryDateTextField.autocapitalizationType = .words
        expiryDateTextField.autocorrectionType = .no
        expiryDateTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerExpiryDateTextFieldTitleColor)
        expiryDateTextField.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerExpiryDateFont, size: 20.0)
        expiryDateTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_task_vc_expiry_date_placeholder", value: "Format - YYYY/MM/DD. Can be empty.", comment: "Add Lead Task VC Expiry Date Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerExpiryDateTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        expiryDateTextField.delegate = self

        self.view.addSubview(expiryDateTextField)

        self.view.addConstraint(expiryDateTextField.topAnchor.constraint(equalTo: expiryDateLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(expiryDateTextField.widthAnchor.constraint(equalTo: (expiryDateTextField.superview?.widthAnchor)!))
        self.view.addConstraint(expiryDateTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupAssignedToLabel() {
        assignedToLabel = UILabel()
        assignedToLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToLabel.text = NSLocalizedString("add_lead_task_vc_assigned_to_label_title", value: " Assigned To",comment: "Add Lead Task VC Assigned To Label Title")
        assignedToLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerAssignedToLabelTitleColor)
        assignedToLabel.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerAssignedToFont, size: 20.0)
        assignedToLabel.sizeToFit()

        self.view.addSubview(assignedToLabel)

        self.view.addConstraint(assignedToLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(assignedToLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToLabel.widthAnchor.constraint(equalTo: (assignedToLabel.superview?.widthAnchor)!, multiplier: 0.50))
    }

    func setupAssignedToUserLabel() {
        assignedToUserLabel = UILabel()
        assignedToUserLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToUserLabel.text = "Rajkumar P"
        assignedToUserLabel.textAlignment = .center
        assignedToUserLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerAssignedToValueTitleColor)
        assignedToUserLabel.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerAssignedToFont, size: 20.0)
        assignedToUserLabel.sizeToFit()

        assignedToUserLabel.isUserInteractionEnabled = true
        assignedToUserLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddLeadTaskViewController.userLabelPressed(_:))))

        self.view.addSubview(assignedToUserLabel)

        self.view.addConstraint(assignedToUserLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(assignedToUserLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToUserLabel.widthAnchor.constraint(equalTo: (assignedToUserLabel.superview?.widthAnchor)!, multiplier: 0.50))
        self.view.addConstraint(assignedToUserLabel.leftAnchor.constraint(equalTo: assignedToLabel.rightAnchor))
    }

    func setupAddLeadTaskButton() {
        addLeadTaskButton = UIButton()
        addLeadTaskButton.translatesAutoresizingMaskIntoConstraints = false

        addLeadTaskButton.setTitle(NSLocalizedString("add_lead_task_vc_add_lead_task_button_title", value: "ADD TASK", comment: "Add Lead VC Add Lead Task Button Title"), for: .normal)
        addLeadTaskButton.setTitleColor(UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerAddLeadTaskButtonTitleColor), for: .normal)
        addLeadTaskButton.backgroundColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerAddLeadTaskButtonBackgroundColor)
        addLeadTaskButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerAddLeadTaskButtonFont, size: 20.0)
        addLeadTaskButton.sizeToFit()

        self.view.addSubview(addLeadTaskButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[addLeadTaskButton(>=50)]-100-|", metrics: nil, views: ["addLeadTaskButton" : addLeadTaskButton]))
        self.view.addConstraint(addLeadTaskButton.topAnchor.constraint(equalTo: assignedToLabel.bottomAnchor, constant: 50.0))
        self.view.addConstraint(addLeadTaskButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(addLeadTaskButton.centerXAnchor.constraint(equalTo: (addLeadTaskButton.superview?.centerXAnchor)!))

        addLeadTaskButton.addTarget(self, action: #selector(AddLeadTaskViewController.addLeadTaskButtonPressed(_:)), for: .touchUpInside)
    }

    func addLeadTaskButtonPressed(_ sender: UIButton) {
        let newLeadTask = Task()
        newLeadTask.taskId = leadId + "__" + DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
        newLeadTask.leadId = leadId
        newLeadTask.taskDescription = taskDescriptionTextField.text!
        newLeadTask.closed = false
        newLeadTask.assignedTo = selectedUser
        newLeadTask.createdBy = realm.object(ofType: User.self, forPrimaryKey: "raj@diskodev.com")

        newLeadTask.createdDate = Date()
        if let expiryDate = expiryDateTextField.text, expiryDateTextField.text != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"

//            newLeadTask.expiryDate = dateFormatter.date(from: expiryDate)
            newLeadTask.expiryDate = dateFormatter.date(from: expiryDate)
            newLeadTask.expiryDeadlineDate = Calendar.current.date(byAdding: .day, value: 1, to: newLeadTask.expiryDate!)
        }
        
        try! realm.write {
            realm.add(newLeadTask)
        }

        addLeadTaskDelegate.didFinishAddingLeadTask(sender: self)
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func userLabelPressed(_ sender: UILabel) {
        let chooseUserTableViewController = ChooseUserTableViewController(user: selectedUser)
        chooseUserTableViewController.userChoosenDelegate = self

        self.navigationController?.pushViewController(chooseUserTableViewController, animated: true)
    }
    
    func didChooseUser(sender: ChooseUserTableViewController, selectedUser: User) {
        self.selectedUser = selectedUser
        assignedToUserLabel.text = self.selectedUser.name
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : AddLeadTaskViewController")
    }
    
}
