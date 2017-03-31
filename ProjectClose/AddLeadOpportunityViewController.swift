//
//  AddLeadOpportunityViewController.swift
//  ProjectClose
//
//  Created by raj on 06/03/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class AddLeadOpportunityViewController: UIViewController, UITextFieldDelegate, UserChoosenDelegate {
    var realm: Realm!
    var leadId: String!

    var descriptionLabel: UILabel!
    var descriptionTextField: UIOffsetUITextField!

    var expiryDateLabel: UILabel!
    var expiryDateTextField: UIOffsetUITextField!

    var valueLabel: UILabel!
    var valueTextField: UITextField!

    var confidenceLabel: UILabel!
    var confidenceTextField: UITextField!

    var assignedToLabel: UILabel!
    var assignedToUserLabel: UILabel!

    var addLeadOpportunityButton: UIButton!

    var currentUserEmail = "raj@diskodev.com"
    var selectedUser: User!

    var addLeadOpportunityDelegate: AddLeadOpportunityDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()
        setupLeftBarButton()

        setupRealm()
        loadCurrentUser(currentUserEmail: currentUserEmail)

        setupOpportunityDescriptionLabel()
        setupOpportunityDescriptionTextField()

        setupOpportunityExpiryDateLabel()
        setupOpportunityExpiryDateTextField()

        setupOpportunityAssignedToLabel()
        setupOpportunityAssignedToUserLabel()

        setupOpportunityValueLabel()
        setupOpportunityValueTextField()

        setupOpportunityConfidenceLabel()
        setupOpportunityConfidenceTextField()

        setupAddLeadOpportunityButton()
    }

    func initTitle() {
        self.title = NSLocalizedString("add_lead_opportunity_vc_title", value: "Add Opportunity", comment: "Add Lead Opportunity VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(AddLeadOpportunityViewController.backButtonPressed(_:)))
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadCurrentUser(currentUserEmail: String) {
        selectedUser = realm.object(ofType: User.self, forPrimaryKey: currentUserEmail)
    }

    func setupOpportunityDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.text = NSLocalizedString("add_lead_opportunity_vc_opportunity_description_label_title", value: " Opportunity Description",comment: "Add Lead Opportunity VC Opportunity Description Label Title")
        descriptionLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerDescriptionTitleColor)
        descriptionLabel.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerDescriptionFont, size: 20.0)
        descriptionLabel.sizeToFit()

        self.view.addSubview(descriptionLabel)

        self.view.addConstraint(descriptionLabel.topAnchor.constraint(equalTo: (descriptionLabel.superview?.topAnchor)!, constant: 50.0))
        self.view.addConstraint(descriptionLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityDescriptionTextField() {
        descriptionTextField = UIOffsetUITextField()
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false

        descriptionTextField.keyboardType = .asciiCapable
        descriptionTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerDescriptionTextFieldTitleColor)
        descriptionTextField.tintColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerTextFieldTintColor)
        descriptionTextField.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerDescriptionFont, size: 20.0)
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_opportunity_vc_opportunity_description_placeholder", value: "e.g. Gob's ready to buy a $3000 suit.", comment: "Add Lead Opportunity VC Opportunity Description Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerDescriptionTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerDescriptionPlaceholderFont, size: 20.0)!])

        descriptionTextField.delegate = self

        self.view.addSubview(descriptionTextField)

        self.view.addConstraint(descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(descriptionTextField.widthAnchor.constraint(equalTo: (descriptionTextField.superview?.widthAnchor)!))
        self.view.addConstraint(descriptionTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityExpiryDateLabel() {
        expiryDateLabel = UILabel()
        expiryDateLabel.translatesAutoresizingMaskIntoConstraints = false

        expiryDateLabel.text = NSLocalizedString("add_lead_opportunity_vc_opportunity_expiry_date_label_title", value: " Expiry Date",comment: "Add Lead Opportunity VC Opportunity Expiry Date Label Title")
        expiryDateLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerExpiryDateTitleColor)
        expiryDateLabel.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerExpiryDateFont, size: 20.0)
        expiryDateLabel.sizeToFit()

        self.view.addSubview(expiryDateLabel)

        self.view.addConstraint(expiryDateLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(expiryDateLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityExpiryDateTextField() {
        expiryDateTextField = UIOffsetUITextField()
        expiryDateTextField.translatesAutoresizingMaskIntoConstraints = false

        expiryDateTextField.keyboardType = .asciiCapable
        expiryDateTextField.autocapitalizationType = .words
        expiryDateTextField.autocorrectionType = .no
        expiryDateTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerExpiryDateTextFieldTitleColor)
        expiryDateTextField.tintColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerTextFieldTintColor)
        expiryDateTextField.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerExpiryDateFont, size: 20.0)
        expiryDateTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_opportunity_vc_opportunity_expiry_date_placeholder", value: "Format - YYYY/MM/DD. Can be empty.", comment: "Add Lead Opportunity VC Opportunity Expiry Date Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerExpiryDateTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerExpiryDatePlaceholderFont, size: 20.0)!])

        expiryDateTextField.delegate = self

        self.view.addSubview(expiryDateTextField)

        self.view.addConstraint(expiryDateTextField.topAnchor.constraint(equalTo: expiryDateLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(expiryDateTextField.widthAnchor.constraint(equalTo: (expiryDateTextField.superview?.widthAnchor)!))
        self.view.addConstraint(expiryDateTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityAssignedToLabel() {
        assignedToLabel = UILabel()
        assignedToLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToLabel.text = NSLocalizedString("add_lead_opportunity_vc_opportunity_assigned_to_label_title", value: " Assigned To",comment: "Add Lead Opportunity VC Opportunity Assigned To Label Title")
        assignedToLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerAssignedToTitleColor)
        assignedToLabel.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerAssignedToFont, size: 20.0)
        assignedToLabel.sizeToFit()

        self.view.addSubview(assignedToLabel)

        self.view.addConstraint(assignedToLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(assignedToLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToLabel.widthAnchor.constraint(equalTo: (assignedToLabel.superview?.widthAnchor)!, multiplier: 0.40))
    }

    func setupOpportunityAssignedToUserLabel() {
        assignedToUserLabel = UILabel()
        assignedToUserLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToUserLabel.text = selectedUser.name
        assignedToUserLabel.textAlignment = .right
        assignedToUserLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerAssignedToValueTitleColor)
        assignedToUserLabel.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerAssignedToFont, size: 20.0)
        assignedToUserLabel.sizeToFit()

        assignedToUserLabel.isUserInteractionEnabled = true
        assignedToUserLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddLeadOpportunityViewController.userLabelPressed(_:))))

        self.view.addSubview(assignedToUserLabel)

        self.view.addConstraint(assignedToUserLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(assignedToUserLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToUserLabel.widthAnchor.constraint(equalTo: (assignedToUserLabel.superview?.widthAnchor)!, multiplier: 0.55))
        self.view.addConstraint(assignedToUserLabel.leftAnchor.constraint(equalTo: assignedToLabel.rightAnchor))
    }

    func setupOpportunityValueLabel() {
        valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        valueLabel.text = NSLocalizedString("add_lead_opportunity_vc_opportunity_value_label_title", value: " Opportunity Value",comment: "Add Lead Opportunity VC Opportunity Value Label Title")
        valueLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerValueTitleColor)
        valueLabel.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerValueFont, size: 20.0)
        valueLabel.sizeToFit()

        self.view.addSubview(valueLabel)

        self.view.addConstraint(valueLabel.widthAnchor.constraint(equalTo: (valueLabel.superview?.widthAnchor)!, multiplier: 0.60))
        self.view.addConstraint(valueLabel.topAnchor.constraint(equalTo: assignedToLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(valueLabel.leftAnchor.constraint(equalTo: (valueLabel.superview?.leftAnchor)!))
        self.view.addConstraint(valueLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityValueTextField() {
        valueTextField = UITextField()
        valueTextField.translatesAutoresizingMaskIntoConstraints = false

        valueTextField.textAlignment = .right
        valueTextField.keyboardType = .numbersAndPunctuation
        valueTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerValueTextFieldTitleColor)
        valueTextField.tintColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerTextFieldTintColor)
        valueTextField.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerValueFont, size: 20.0)
        valueTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_opportunity_vc_opportunity_value_placeholder", value: "e.g. 3,000", comment: "Add Lead Opportunity VC Opportunity Value Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerValueTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerValuePlaceholderFont, size: 20.0)!])

        valueTextField.delegate = self

        self.view.addSubview(valueTextField)

        self.view.addConstraint(valueTextField.widthAnchor.constraint(equalTo: (valueTextField.superview?.widthAnchor)!, multiplier: 0.35))
        self.view.addConstraint(valueTextField.topAnchor.constraint(equalTo: assignedToUserLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(valueTextField.rightAnchor.constraint(equalTo: assignedToUserLabel.rightAnchor))
//        self.view.addConstraint(valueTextField.leftAnchor.constraint(equalTo: valueLabel.rightAnchor))
        self.view.addConstraint(valueTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityConfidenceLabel() {
        confidenceLabel = UILabel()
        confidenceLabel.translatesAutoresizingMaskIntoConstraints = false

        confidenceLabel.text = NSLocalizedString("add_lead_opportunity_vc_opportunity_confidence_label_title", value: " Opportunity Confidence %",comment: "Add Lead Opportunity VC Opportunity Confidence Label Title")
        confidenceLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerConfidenceTitleColor)
        confidenceLabel.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerConfidenceFont, size: 20.0)
        confidenceLabel.sizeToFit()

        self.view.addSubview(confidenceLabel)

        self.view.addConstraint(confidenceLabel.widthAnchor.constraint(equalTo: (confidenceLabel.superview?.widthAnchor)!, multiplier: 0.75))
        self.view.addConstraint(confidenceLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(confidenceLabel.leftAnchor.constraint(equalTo: (confidenceLabel.superview?.leftAnchor)!))
        self.view.addConstraint(confidenceLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityConfidenceTextField() {
        confidenceTextField = UITextField()
        confidenceTextField.translatesAutoresizingMaskIntoConstraints = false

        confidenceTextField.textAlignment = .right
        confidenceTextField.keyboardType = .numbersAndPunctuation
        confidenceTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerConfidenceTextFieldTitleColor)
        confidenceTextField.tintColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerTextFieldTintColor)
        confidenceTextField.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerConfidenceFont, size: 20.0)
        confidenceTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_opportunity_vc_opportunity_confidence_placeholder", value: "e.g. 60", comment: "Add Lead Opportunity VC Opportunity Confidence Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerConfidenceTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerConfidencePlaceholderFont, size: 20.0)!])

        confidenceTextField.delegate = self

        self.view.addSubview(confidenceTextField)

        self.view.addConstraint(confidenceTextField.widthAnchor.constraint(equalTo: (confidenceTextField.superview?.widthAnchor)!, multiplier: 0.20))
        self.view.addConstraint(confidenceTextField.topAnchor.constraint(equalTo: valueTextField.bottomAnchor, constant: 5.0))
        self.view.addConstraint(confidenceTextField.rightAnchor.constraint(equalTo: valueTextField.rightAnchor))
        self.view.addConstraint(confidenceTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupAddLeadOpportunityButton() {
        addLeadOpportunityButton = UIButton()
        addLeadOpportunityButton.translatesAutoresizingMaskIntoConstraints = false

        addLeadOpportunityButton.setTitle(NSLocalizedString("add_lead_opportunity_add_lead_opportunity_button_title", value: "ADD OPPORTUNITY", comment: "Add Lead Opportunity VC Add Lead Opportunity Button Title"), for: .normal)
        addLeadOpportunityButton.setTitleColor(UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerAddLeadOpportunityButtonTitleColor), for: .normal)
        addLeadOpportunityButton.backgroundColor = UIColor(hexString: ProjectCloseColors.addLeadOpportunityViewControllerAddLeadOpportunityButtonBackgroundColor)
        addLeadOpportunityButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.addLeadOpportunityViewControllerAddLeadOpportunityButtonFont, size: 20.0)
        addLeadOpportunityButton.sizeToFit()

        self.view.addSubview(addLeadOpportunityButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[addLeadOpportunityButton(>=50)]-50-|", metrics: nil, views: ["addLeadOpportunityButton" : addLeadOpportunityButton]))
        self.view.addConstraint(addLeadOpportunityButton.topAnchor.constraint(equalTo: confidenceLabel.bottomAnchor, constant: 50.0))
        self.view.addConstraint(addLeadOpportunityButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(addLeadOpportunityButton.centerXAnchor.constraint(equalTo: (addLeadOpportunityButton.superview?.centerXAnchor)!))

        addLeadOpportunityButton.addTarget(self, action: #selector(AddLeadOpportunityViewController.addLeadOpportunityButtonPressed(_:)), for: .touchUpInside)
    }

    func addLeadOpportunityButtonPressed(_ sender: UIButton) {
        let newLeadOpportunity = Opportunity()
        newLeadOpportunity.opportunityId = leadId + "__" + DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
        newLeadOpportunity.leadId = leadId
        newLeadOpportunity.opportunityDescription = descriptionTextField.text!
        newLeadOpportunity.assignedTo = selectedUser
        newLeadOpportunity.createdBy = realm.object(ofType: User.self, forPrimaryKey: "raj@diskodev.com")

        newLeadOpportunity.value = Int(valueTextField.text!)!
        newLeadOpportunity.confidence = Double(confidenceTextField.text!)!

        newLeadOpportunity.createdDate = Date()
        if let expiryDate = expiryDateTextField.text, expiryDateTextField.text != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"

            newLeadOpportunity.expiryDate = dateFormatter.date(from: expiryDate)
        }

        newLeadOpportunity.status = "Active"

        try! realm.write {
            realm.add(newLeadOpportunity)
        }

        addLeadOpportunityDelegate.didFinishAddingLeadOpportunity(sender: self)
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
        print("Memory warning : AddLeadOpportunityViewController")
    }

}
