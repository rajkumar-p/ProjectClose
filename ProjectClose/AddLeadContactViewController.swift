//
//  AddLeadContactViewController.swift
//  ProjectClose
//
//  Created by raj on 06/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class AddLeadContactViewController: UIViewController, UITextFieldDelegate {
    var realm: Realm!
    var leadId: String!

    var nameLabel: UILabel!
    var nameTextField: UIOffsetUITextField!

    var emailLabel: UILabel!
    var emailTextField: UIOffsetUITextField!

    var phoneLabel: UILabel!
    var phoneTextField: UIOffsetUITextField!

    var addLeadContactButton: UIButton!

    var addLeadContactDelegate: AddLeadContactDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()

        setupLeftBarButton()

        setupNameLabel()
        setupNameTextField()

        setupEmailLabel()
        setupEmailTextField()

        setupPhoneLabel()
        setupPhoneTextField()

        setupAddLeadContactButton()

        setupRealm()
    }

    func initTitle() {
        self.title = NSLocalizedString("add_lead_contact_vc_title", value: "Add Contact", comment: "Add Lead Contact VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(AddLeadContactViewController.backButtonPressed(_:)))
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.text = NSLocalizedString("add_lead_contact_vc_company_name_label_title", value: " Full Name",comment: "Add Lead Contact VC Company Name Label Title")
        nameLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerNameTitleColor)
        nameLabel.font = UIFont(name: ProjectCloseFonts.addLeadContactViewControllerNameFont, size: 20.0)
        nameLabel.sizeToFit()

        self.view.addSubview(nameLabel)

        self.view.addConstraint(nameLabel.topAnchor.constraint(equalTo: (nameLabel.superview?.topAnchor)!, constant: 50.0))
        self.view.addConstraint(nameLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupNameTextField() {
        nameTextField = UIOffsetUITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false

        nameTextField.keyboardType = .asciiCapable
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        nameTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerNameTextFieldTitleColor)
        nameTextField.font = UIFont(name: ProjectCloseFonts.addLeadContactViewControllerNameFont, size: 20.0)
        nameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_contact_vc_company_name_placeholder", value: "e.g. Mike Ray", comment: "Add Lead Contact VC Company Name Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerNameTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadContactViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        nameTextField.delegate = self

        self.view.addSubview(nameTextField)

        self.view.addConstraint(nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(nameTextField.widthAnchor.constraint(equalTo: (nameTextField.superview?.widthAnchor)!))
        self.view.addConstraint(nameTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false

        emailLabel.text = NSLocalizedString("add_lead_contact_vc_company_email_label_title", value: " Email",comment: "Add Lead Contact VC Company Email Label Title")
        emailLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerEmailTitleColor)
        emailLabel.font = UIFont(name: ProjectCloseFonts.addLeadContactViewControllerEmailFont, size: 20.0)
        emailLabel.sizeToFit()

        self.view.addSubview(emailLabel)

        self.view.addConstraint(emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(emailLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupEmailTextField() {
        emailTextField = UIOffsetUITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerEmailTextFieldTitleColor)
        emailTextField.font = UIFont(name: ProjectCloseFonts.addLeadContactViewControllerEmailFont, size: 20.0)
        emailTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_contact_vc_company_email_placeholder", value: "e.g. mike.ray@example.com", comment: "Add Lead Contact VC Company Email Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerEmailTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadContactViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        emailTextField.delegate = self

        self.view.addSubview(emailTextField)

        self.view.addConstraint(emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(emailTextField.widthAnchor.constraint(equalTo: (emailTextField.superview?.widthAnchor)!))
        self.view.addConstraint(emailTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false

        phoneLabel.text = NSLocalizedString("add_lead_contact_vc_company_phone_label_title", value: " Phone Number",comment: "Add Lead Contact VC Company Phone Label Title")
        phoneLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerPhoneTitleColor)
        phoneLabel.font = UIFont(name: ProjectCloseFonts.addLeadContactViewControllerPhoneFont, size: 20.0)
        phoneLabel.sizeToFit()

        self.view.addSubview(phoneLabel)

        self.view.addConstraint(phoneLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(phoneLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupPhoneTextField() {
        phoneTextField = UIOffsetUITextField()
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false

        phoneTextField.keyboardType = .phonePad
        phoneTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerPhoneTextFieldTitleColor)
        phoneTextField.font = UIFont(name: ProjectCloseFonts.addLeadContactViewControllerPhoneFont, size: 20.0)
        phoneTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_contact_vc_company_phone_placeholder", value: "e.g. +123456789", comment: "Add Lead Contact VC Company Phone Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerPhoneTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadContactViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        phoneTextField.delegate = self

        self.view.addSubview(phoneTextField)

        self.view.addConstraint(phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(phoneTextField.widthAnchor.constraint(equalTo: (phoneTextField.superview?.widthAnchor)!))
        self.view.addConstraint(phoneTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupAddLeadContactButton() {
        addLeadContactButton = UIButton()
        addLeadContactButton.translatesAutoresizingMaskIntoConstraints = false

        addLeadContactButton.setTitle(NSLocalizedString("add_lead_task_vc_add_lead_contact_button_title", value: "ADD CONTACT", comment: "Add Lead VC Add Lead Contact Button Title"), for: .normal)
        addLeadContactButton.setTitleColor(UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerAddLeadContactButtonTitleColor), for: .normal)
        addLeadContactButton.backgroundColor = UIColor(hexString: ProjectCloseColors.addLeadContactViewControllerAddLeadContactButtonBackgroundColor)
        addLeadContactButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.addLeadContactViewControllerAddLeadContactButtonFont, size: 20.0)
        addLeadContactButton.sizeToFit()

        self.view.addSubview(addLeadContactButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[addLeadContactButton(>=50)]-100-|", metrics: nil, views: ["addLeadContactButton" : addLeadContactButton]))
        self.view.addConstraint(addLeadContactButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 50.0))
        self.view.addConstraint(addLeadContactButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(addLeadContactButton.centerXAnchor.constraint(equalTo: (addLeadContactButton.superview?.centerXAnchor)!))

        addLeadContactButton.addTarget(self, action: #selector(AddLeadContactViewController.addLeadContactButtonPressed(_:)), for: .touchUpInside)
    }

    func addLeadContactButtonPressed(_ sender: UIButton) {
        let leadContactToBeAdded = Contact()
        leadContactToBeAdded.name = nameTextField.text
        leadContactToBeAdded.email = emailTextField.text
        leadContactToBeAdded.phone = phoneTextField.text

        leadContactToBeAdded.contactId = leadId + "__" + leadContactToBeAdded.name + "__" + leadContactToBeAdded.email
        leadContactToBeAdded.leadId = leadId

        try! realm.write {
            realm.add(leadContactToBeAdded)
        }

        addLeadContactDelegate.didFinishAddingLeadContact(sender: self)
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : AddLeadContactViewController")
    }
    
}
