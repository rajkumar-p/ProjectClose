//
//  AddOpportunityViewController.swift
//  ProjectClose
//
//  Created by raj on 09/03/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class AddOpportunityViewController: UIViewController, UITextFieldDelegate, UserChoosenDelegate, LeadChoosenDelegate {
    var realm: Realm!
    var selectedUser: User!
    var selectedLead: Lead!

    var descriptionLabel: UILabel!
    var descriptionTextField: UIOffsetUITextField!

    var expiryDateLabel: UILabel!
    var expiryDateTextField: UIOffsetUITextField!

    var leadLabel: UILabel!
    var assignedToLeadLabel: UILabel!

    var valueLabel: UILabel!
    var valueTextField: UITextField!

    var confidenceLabel: UILabel!
    var confidenceTextField: UITextField!

    var assignedToLabel: UILabel!
    var assignedToUserLabel: UILabel!

    var addLeadOpportunityButton: UIButton!

    var currentUserEmail = "raj@diskodev.com"

    var addOpportunityDelegate: AddOpportunityDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()
        setupLeftBarButton()

        setupRealm()
        loadInitialLeadAndUser()

        setupOpportunityDescriptionLabel()
        setupOpportunityDescriptionTextField()

        setupOpportunityExpiryDateLabel()
        setupOpportunityExpiryDateTextField()

        setupOpportunityLeadLabel()
        setupOpportunityAssignedToLeadLabel()

        setupOpportunityAssignedToLabel()
        setupOpportunityAssignedToUserLabel()

        setupOpportunityValueLabel()
        setupOpportunityValueTextField()

        setupOpportunityConfidenceLabel()
        setupOpportunityConfidenceTextField()

        setupAddLeadOpportunityButton()
    }

    func initTitle() {
        self.title = NSLocalizedString("add_opportunity_vc_title", value: "Add Opportunity", comment: "Add Opportunity VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(AddOpportunityViewController.backButtonPressed(_:)))
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func loadInitialLeadAndUser() {
        selectedLead = realm.objects(Lead.self).first
        selectedUser = realm.objects(User.self).first
    }

    func setupOpportunityDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.text = NSLocalizedString("add_opportunity_vc_opportunity_description_label_title", value: " Opportunity Description",comment: "Add Opportunity VC Opportunity Description Label Title")
        descriptionLabel.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerDescriptionTitleColor)
        descriptionLabel.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerDescriptionFont, size: 20.0)
        descriptionLabel.sizeToFit()

        self.view.addSubview(descriptionLabel)

        self.view.addConstraint(descriptionLabel.topAnchor.constraint(equalTo: (descriptionLabel.superview?.topAnchor)!, constant: 50.0))
        self.view.addConstraint(descriptionLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityDescriptionTextField() {
        descriptionTextField = UIOffsetUITextField()
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false

        descriptionTextField.keyboardType = .asciiCapable
        descriptionTextField.autocapitalizationType = .words
        descriptionTextField.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerDescriptionTextFieldTitleColor)
        descriptionTextField.tintColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerTextFieldTintColor)
        descriptionTextField.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerDescriptionFont, size: 20.0)
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_opportunity_vc_opportunity_description_placeholder", value: "e.g. Gob's ready to buy a $3000 suit.", comment: "Add Opportunity VC Opportunity Description Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerDescriptionTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addOpportunityViewControllerDescriptionPlaceholderFont, size: 20.0)!])

        descriptionTextField.delegate = self

        self.view.addSubview(descriptionTextField)

        self.view.addConstraint(descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(descriptionTextField.widthAnchor.constraint(equalTo: (descriptionTextField.superview?.widthAnchor)!))
        self.view.addConstraint(descriptionTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityExpiryDateLabel() {
        expiryDateLabel = UILabel()
        expiryDateLabel.translatesAutoresizingMaskIntoConstraints = false

        expiryDateLabel.text = NSLocalizedString("add_opportunity_vc_opportunity_expiry_date_label_title", value: " Expiry Date",comment: "Add Opportunity VC Opportunity Expiry Date Label Title")
        expiryDateLabel.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerExpiryDateTitleColor)
        expiryDateLabel.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerExpiryDateFont, size: 20.0)
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
        expiryDateTextField.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerExpiryDateTextFieldTitleColor)
        expiryDateTextField.tintColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerTextFieldTintColor)
        expiryDateTextField.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerExpiryDateFont, size: 20.0)
        expiryDateTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_opportunity_vc_opportunity_expiry_date_placeholder", value: "Format - YYYY/MM/DD. Can be empty.", comment: "Add Opportunity VC Opportunity Expiry Date Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerExpiryDateTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addOpportunityViewControllerExpiryDatePlaceholderFont, size: 20.0)!])

        expiryDateTextField.delegate = self

        self.view.addSubview(expiryDateTextField)

        self.view.addConstraint(expiryDateTextField.topAnchor.constraint(equalTo: expiryDateLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(expiryDateTextField.widthAnchor.constraint(equalTo: (expiryDateTextField.superview?.widthAnchor)!))
        self.view.addConstraint(expiryDateTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupOpportunityLeadLabel() {
        leadLabel = UILabel()
        leadLabel.translatesAutoresizingMaskIntoConstraints = false

        leadLabel.text = NSLocalizedString("add_opportunity_vc_lead_label_title", value: " Lead",comment: "Add Opportunity VC Lead Label Title")
        leadLabel.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerLeadLabelTitleColor)
        leadLabel.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerLeadFont, size: 20.0)
        leadLabel.sizeToFit()

        self.view.addSubview(leadLabel)

        self.view.addConstraint(leadLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(leadLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(leadLabel.widthAnchor.constraint(equalTo: (leadLabel.superview?.widthAnchor)!, multiplier: 0.50))
    }

    func setupOpportunityAssignedToLeadLabel() {
        assignedToLeadLabel = UILabel()
        assignedToLeadLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToLeadLabel.text = selectedLead.companyName
        assignedToLeadLabel.textAlignment = .right
        assignedToLeadLabel.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerLeadValueTitleColor)
        assignedToLeadLabel.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerLeadFont, size: 20.0)
        assignedToLeadLabel.sizeToFit()

        assignedToLeadLabel.isUserInteractionEnabled = true
        assignedToLeadLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddOpportunityViewController.leadLabelPressed(_:))))

        self.view.addSubview(assignedToLeadLabel)

        self.view.addConstraint(assignedToLeadLabel.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(assignedToLeadLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToLeadLabel.widthAnchor.constraint(equalTo: (assignedToLeadLabel.superview?.widthAnchor)!, multiplier: 0.49))
        self.view.addConstraint(assignedToLeadLabel.leftAnchor.constraint(equalTo: leadLabel.rightAnchor))
    }

    func setupOpportunityAssignedToLabel() {
        assignedToLabel = UILabel()
        assignedToLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToLabel.text = NSLocalizedString("add_opportunity_vc_opportunity_assigned_to_label_title", value: " Assigned To",comment: "Add Opportunity VC Opportunity Assigned To Label Title")
        assignedToLabel.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerAssignedToLabelTitleColor)
        assignedToLabel.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerAssignedToFont, size: 20.0)
        assignedToLabel.sizeToFit()

        self.view.addSubview(assignedToLabel)

        self.view.addConstraint(assignedToLabel.topAnchor.constraint(equalTo: assignedToLeadLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(assignedToLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToLabel.widthAnchor.constraint(equalTo: (assignedToLabel.superview?.widthAnchor)!, multiplier: 0.40))
    }

    func setupOpportunityAssignedToUserLabel() {
        assignedToUserLabel = UILabel()
        assignedToUserLabel.translatesAutoresizingMaskIntoConstraints = false

        assignedToUserLabel.text = selectedUser.name
        assignedToUserLabel.textAlignment = .right
        assignedToUserLabel.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerAssignedToValueTitleColor)
        assignedToUserLabel.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerAssignedToFont, size: 20.0)
        assignedToUserLabel.sizeToFit()

        assignedToUserLabel.isUserInteractionEnabled = true
        assignedToUserLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddOpportunityViewController.userLabelPressed(_:))))

        self.view.addSubview(assignedToUserLabel)

        self.view.addConstraint(assignedToUserLabel.topAnchor.constraint(equalTo: assignedToLeadLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(assignedToUserLabel.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(assignedToUserLabel.widthAnchor.constraint(equalTo: (assignedToUserLabel.superview?.widthAnchor)!, multiplier: 0.55))
        self.view.addConstraint(assignedToUserLabel.leftAnchor.constraint(equalTo: assignedToLabel.rightAnchor))
    }

    func setupOpportunityValueLabel() {
        valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        valueLabel.text = NSLocalizedString("add_opportunity_vc_opportunity_value_label_title", value: " Opportunity Value",comment: "Add Opportunity VC Opportunity Value Label Title")
        valueLabel.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerValueTitleColor)
        valueLabel.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerValueFont, size: 20.0)
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
        valueTextField.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerValueTextFieldTitleColor)
        valueTextField.tintColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerTextFieldTintColor)
        valueTextField.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerValueFont, size: 20.0)
        valueTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_opportunity_vc_opportunity_value_placeholder", value: "e.g. 3,000", comment: "Add Opportunity VC Opportunity Value Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerValueTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addOpportunityViewControllerValuePlaceholderFont, size: 20.0)!])

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

        confidenceLabel.text = NSLocalizedString("add_opportunity_vc_opportunity_confidence_label_title", value: " Opportunity Confidence %",comment: "Add Opportunity VC Opportunity Confidence Label Title")
        confidenceLabel.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerConfidenceTitleColor)
        confidenceLabel.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerConfidenceFont, size: 20.0)
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
        confidenceTextField.textColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerConfidenceTextFieldTitleColor)
        confidenceTextField.tintColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerTextFieldTintColor)
        confidenceTextField.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerConfidenceFont, size: 20.0)
        confidenceTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_opportunity_vc_opportunity_confidence_placeholder", value: "e.g. 60", comment: "Add Opportunity VC Opportunity Confidence Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerConfidenceTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addOpportunityViewControllerConfidencePlaceholderFont, size: 20.0)!])

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

        addLeadOpportunityButton.setTitle(NSLocalizedString("add_opportunity_add_lead_opportunity_button_title", value: "ADD OPPORTUNITY", comment: "Add Opportunity VC Add Lead Opportunity Button Title"), for: .normal)
        addLeadOpportunityButton.setTitleColor(UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerAddOpportunityButtonTitleColor), for: .normal)
        addLeadOpportunityButton.backgroundColor = UIColor(hexString: ProjectCloseColors.addOpportunityViewControllerAddOpportunityButtonBackgroundColor)
        addLeadOpportunityButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.addOpportunityViewControllerAddOpportunityButtonFont, size: 20.0)
        addLeadOpportunityButton.sizeToFit()

        self.view.addSubview(addLeadOpportunityButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[addLeadOpportunityButton(>=50)]-50-|", metrics: nil, views: ["addLeadOpportunityButton" : addLeadOpportunityButton]))
        self.view.addConstraint(addLeadOpportunityButton.topAnchor.constraint(equalTo: confidenceLabel.bottomAnchor, constant: 50.0))
        self.view.addConstraint(addLeadOpportunityButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(addLeadOpportunityButton.centerXAnchor.constraint(equalTo: (addLeadOpportunityButton.superview?.centerXAnchor)!))

        addLeadOpportunityButton.addTarget(self, action: #selector(AddOpportunityViewController.addOpportunityButtonPressed(_:)), for: .touchUpInside)
    }

    func leadLabelPressed(_ sender: UILabel) {
        let chooseLeadTableViewController = ChooseLeadTableViewController(lead: selectedLead)
        chooseLeadTableViewController.leadChoosenDelegate = self

        self.navigationController?.pushViewController(chooseLeadTableViewController, animated: true)
    }

    func didChooseLead(sender: ChooseLeadTableViewController, selectedLead: Lead) {
        self.selectedLead = selectedLead
        assignedToLeadLabel.text = self.selectedLead.companyName
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

    func addOpportunityButtonPressed(_ sender: UIButton) {
        let newOpportunity = Opportunity()
        newOpportunity.opportunityId = selectedLead.leadId + "__" + DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
        newOpportunity.leadId = selectedLead.leadId
        newOpportunity.opportunityDescription = descriptionTextField.text!
        newOpportunity.assignedTo = selectedUser
        newOpportunity.createdBy = realm.object(ofType: User.self, forPrimaryKey: "raj@diskodev.com")

        newOpportunity.value = Int(valueTextField.text!)!
        newOpportunity.confidence = Double(confidenceTextField.text!)!

        newOpportunity.createdDate = Date()
        if let expiryDate = expiryDateTextField.text, expiryDateTextField.text != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"

            newOpportunity.expiryDate = dateFormatter.date(from: expiryDate)
        }

        newOpportunity.status = "Active"

        try! realm.write {
            realm.add(newOpportunity)
        }

        addOpportunityDelegate.didFinishAddingOpportunity(sender: self)
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
