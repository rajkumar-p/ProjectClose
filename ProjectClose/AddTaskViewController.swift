//
//  AddTaskWithLeadViewController.swift
//  ProjectClose
//
//  Created by raj on 22/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController, UITextFieldDelegate, UserChoosenDelegate, LeadChoosenDelegate {
    var realm: Realm!
    var selectedUser: User!
    var selectedLead: Lead!

    var taskDescriptionLabel: UILabel!
    var taskDescriptionTextField: UIOffsetUITextField!

    var expiryDateLabel: UILabel!
    var expiryDateTextField: UIOffsetUITextField!

    var leadLabel: UILabel!
    var assignedToLeadLabel: UILabel!

    var assignedToLabel: UILabel!
    var assignedToUserLabel: UILabel!

    var addLeadTaskButton: UIButton!

    var addTaskDelegate: AddTaskDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()
        setupLeftBarButton()

        setupRealm()
        loadInitialLeadAndUser()

        setupTaskDescriptionLabel()
        setupTaskDescriptionTextField()

        setupExpiryDateLabel()
        setupExpiryDateTextField()

        setupLeadLabel()
        setupAssignedToLeadLabel()

        setupAssignedToLabel()
        setupAssignedToUserLabel()

        setupAddLeadTaskButton()
    }

    func initTitle() {
        self.title = NSLocalizedString("add_task_vc_title", value: "Add Task", comment: "Add Task VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(AddTaskViewController.backButtonPressed(_:)))
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadInitialLeadAndUser() {
        selectedLead = realm.objects(Lead.self).first
        selectedUser = realm.objects(User.self).first
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func setupTaskDescriptionLabel() {
        taskDescriptionLabel = UILabel()
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        taskDescriptionLabel.text = NSLocalizedString("add_lead_vc_company_name_label_title", value: " Task Description",comment: "Add Lead VC Company Name Label Title")
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
        taskDescriptionTextField.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerTaskDescriptionFont, size: 20.0)
        taskDescriptionTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_vc_company_name_placeholder", value: "e.g. Call Brady", comment: "Add Lead VC Company Name Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerTaskDescriptionTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        taskDescriptionTextField.delegate = self

        self.view.addSubview(taskDescriptionTextField)

        self.view.addConstraint(taskDescriptionTextField.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(taskDescriptionTextField.widthAnchor.constraint(equalTo: (taskDescriptionTextField.superview?.widthAnchor)!))
        self.view.addConstraint(taskDescriptionTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupExpiryDateLabel() {
        expiryDateLabel = UILabel()
        expiryDateLabel.translatesAutoresizingMaskIntoConstraints = false

        expiryDateLabel.text = NSLocalizedString("add_task_vc_expiry_date_label_title", value: " Expiry Date",comment: "Add Lead VC Expiry Date Label Title")
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
        expiryDateTextField.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerExpiryDateFont, size: 20.0)
        expiryDateTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_task_vc_expiry_date_placeholder", value: "Format - YYYY/MM/DD. Can be empty.", comment: "Add Task VC Expiry Date Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerExpiryDateTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        expiryDateTextField.delegate = self

        self.view.addSubview(expiryDateTextField)

        self.view.addConstraint(expiryDateTextField.topAnchor.constraint(equalTo: expiryDateLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(expiryDateTextField.widthAnchor.constraint(equalTo: (expiryDateTextField.superview?.widthAnchor)!))
        self.view.addConstraint(expiryDateTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupLeadLabel() {
        leadLabel = UILabel()
        leadLabel.translatesAutoresizingMaskIntoConstraints = false

        leadLabel.text = NSLocalizedString("add_task_vc_lead_label_title", value: " Lead",comment: "Add Task VC Lead Label Title")
        leadLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerLeadTitleColor)
        leadLabel.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerLeadFont, size: 20.0)
        leadLabel.sizeToFit()

        self.view.addSubview(leadLabel)

        self.view.addConstraint(leadLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(leadLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(leadLabel.widthAnchor.constraint(equalTo: (leadLabel.superview?.widthAnchor)!, multiplier: 0.50))
    }

    func setupAssignedToLeadLabel() {
        assignedToLeadLabel = UILabel()
        assignedToLeadLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToLeadLabel.text = selectedLead.companyName
        assignedToLeadLabel.textAlignment = .right
        assignedToLeadLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerLeadTitleColor)
        assignedToLeadLabel.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerAssignedToFont, size: 20.0)
        assignedToLeadLabel.sizeToFit()

        assignedToLeadLabel.isUserInteractionEnabled = true
        assignedToLeadLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddTaskViewController.leadLabelPressed(_:))))

        self.view.addSubview(assignedToLeadLabel)

        self.view.addConstraint(assignedToLeadLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(assignedToLeadLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToLeadLabel.widthAnchor.constraint(equalTo: (assignedToLeadLabel.superview?.widthAnchor)!, multiplier: 0.49))
        self.view.addConstraint(assignedToLeadLabel.leftAnchor.constraint(equalTo: leadLabel.rightAnchor))
    }

    func setupAssignedToLabel() {
        assignedToLabel = UILabel()
        assignedToLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToLabel.text = NSLocalizedString("add_task_vc_assigned_to_label_title", value: " Assigned To",comment: "Add Task VC Assigned To Label Title")
        assignedToLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerAssignedToTitleColor)
        assignedToLabel.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerAssignedToFont, size: 20.0)
        assignedToLabel.sizeToFit()

        self.view.addSubview(assignedToLabel)

        self.view.addConstraint(assignedToLabel.topAnchor.constraint(equalTo: leadLabel.bottomAnchor, constant: 20.0))
        self.view.addConstraint(assignedToLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToLabel.widthAnchor.constraint(equalTo: (assignedToLabel.superview?.widthAnchor)!, multiplier: 0.50))
    }

    func setupAssignedToUserLabel() {
        assignedToUserLabel = UILabel()
        assignedToUserLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToUserLabel.text = selectedUser.name
        assignedToUserLabel.textAlignment = .right
        assignedToUserLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerAssignedToTitleColor)
        assignedToUserLabel.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerAssignedToFont, size: 20.0)
        assignedToUserLabel.sizeToFit()

        assignedToUserLabel.isUserInteractionEnabled = true
        assignedToUserLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddTaskViewController.userLabelPressed(_:))))

        self.view.addSubview(assignedToUserLabel)

        self.view.addConstraint(assignedToUserLabel.topAnchor.constraint(equalTo: assignedToLeadLabel.bottomAnchor, constant: 20.0))
        self.view.addConstraint(assignedToUserLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToUserLabel.widthAnchor.constraint(equalTo: (assignedToUserLabel.superview?.widthAnchor)!, multiplier: 0.49))
        self.view.addConstraint(assignedToUserLabel.leftAnchor.constraint(equalTo: assignedToLabel.rightAnchor))
    }

    func setupAddLeadTaskButton() {
        addLeadTaskButton = UIButton()
        addLeadTaskButton.translatesAutoresizingMaskIntoConstraints = false

        addLeadTaskButton.setTitle(NSLocalizedString("add_task_vc_add_lead_button_title", value: "ADD TASK", comment: "Add Task VC Add Task Button Title"), for: .normal)
        addLeadTaskButton.setTitleColor(UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerAddLeadTaskButtonTitleColor), for: .normal)
        addLeadTaskButton.backgroundColor = UIColor(hexString: ProjectCloseColors.addLeadTasksViewControllerAddLeadTaskButtonBackgroundColor)
        addLeadTaskButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.addLeadTasksViewControllerAddLeadTaskButtonFont, size: 20.0)
        addLeadTaskButton.sizeToFit()

        self.view.addSubview(addLeadTaskButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[addLeadTaskButton(>=50)]-100-|", metrics: nil, views: ["addLeadTaskButton" : addLeadTaskButton]))
        self.view.addConstraint(addLeadTaskButton.topAnchor.constraint(equalTo: assignedToLabel.bottomAnchor, constant: 50.0))
        self.view.addConstraint(addLeadTaskButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(addLeadTaskButton.centerXAnchor.constraint(equalTo: (addLeadTaskButton.superview?.centerXAnchor)!))

        addLeadTaskButton.addTarget(self, action: #selector(AddTaskViewController.addLeadTaskButtonPressed(_:)), for: .touchUpInside)
    }

    func addLeadTaskButtonPressed(_ sender: UIButton) {
        let newTask = Task()
        newTask.taskId = selectedLead.leadId + "__" + DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
        newTask.leadId = selectedLead.leadId
        newTask.taskDescription = taskDescriptionTextField.text!
        newTask.closed = false
        newTask.assignedTo = selectedUser
        newTask.createdBy = realm.object(ofType: User.self, forPrimaryKey: "raj@diskodev.com")

        newTask.createdDate = Date()
        if let expiryDate = expiryDateTextField.text {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"

//            newTask.expiryDate = dateFormatter.date(from: expiryDate)
            newTask.expiryDate = Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: expiryDate)!)
        }

        try! realm.write {
            realm.add(newTask)
        }

        addTaskDelegate.didFinishAddingTask(sender: self)
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func leadLabelPressed(_ sender: UILabel) {
        let chooseLeadTableViewController = ChooseLeadTableViewController(lead: selectedLead)
        chooseLeadTableViewController.leadChoosenDelegate = self

        self.navigationController?.pushViewController(chooseLeadTableViewController, animated: true)
    }

    func userLabelPressed(_ sender: UILabel) {
        let chooseUserTableViewController = ChooseUserTableViewController(user: selectedUser)
        chooseUserTableViewController.userChoosenDelegate = self

        self.navigationController?.pushViewController(chooseUserTableViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : AddTaskWithLeadViewController")
    }

    func didChooseUser(sender: ChooseUserTableViewController, selectedUser: User) {
        self.selectedUser = selectedUser
        assignedToUserLabel.text = self.selectedUser.name
    }

    func didChooseLead(sender: ChooseLeadTableViewController, selectedLead: Lead) {
        self.selectedLead = selectedLead
        assignedToLeadLabel.text = self.selectedLead.companyName
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
