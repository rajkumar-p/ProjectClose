//
//  AddLeadViewController.swift
//  ProjectClose
//
//  Created by raj on 20/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift
import PagingMenuController

class AddLeadViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var realm: Realm!

    var companyNameLabel: UILabel!
    var companyNameTextField: UIOffsetUITextField!

    var companyDescriptionLabel: UILabel!
    var companyDescriptionTextField: UIOffsetUITextField!

    var companyAddressLabel: UILabel!
    var companyAddressTextView: UITextView!
    var companyAddressTextViewEdited = false
    var companyAddressTextViewPlaceholderString = NSLocalizedString("add_lead_vc_company_address_placeholder", value: " e.g. 48/7, Awesome Street,\n Awesome City, \n Awesome State.\n 111111", comment: "Add Lead VC Company Address Placeholder")

    var addLeadButton: UIButton!

    var addDelegate: AddLeadDelegate!
    var changeDelegate: ChangeLeadDelegate!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()
        setupLeftBarButton()

        setupCompanyNameLabel()
        setupCompanyNameTextField()
        
        setupCompanyDescriptionLabel()
        setupCompanyDescriptionTextField()

        setupCompanyAddressLabel()
        setupCompanyAddressTextView()

        setupAddLeadButton()
    }

    func initTitle() {
        self.title = NSLocalizedString("add_lead_vc_title", value: "Add Lead", comment: "Add Lead VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(AddUserViewController.backButtonPressed(_:)))
    }

    func setupCompanyNameLabel() {
        companyNameLabel = UILabel()
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false

        companyNameLabel.text = NSLocalizedString("add_lead_vc_company_name_label_title", value: " Company Name",comment: "Add Lead VC Company Name Label Title")
        companyNameLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyNameTitleColor)
        companyNameLabel.font = UIFont(name: ProjectCloseFonts.addLeadViewControllerCompanyNameFont, size: 20.0)
        companyNameLabel.sizeToFit()

        self.view.addSubview(companyNameLabel)

        self.view.addConstraint(companyNameLabel.topAnchor.constraint(equalTo: (companyNameLabel.superview?.topAnchor)!, constant: 50.0))
        self.view.addConstraint(companyNameLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupCompanyNameTextField() {
        companyNameTextField = UIOffsetUITextField()
        companyNameTextField.translatesAutoresizingMaskIntoConstraints = false

        companyNameTextField.keyboardType = .asciiCapable
        companyNameTextField.autocapitalizationType = .words
        companyNameTextField.autocorrectionType = .no
        companyNameTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyNameTextFieldTitleColor)
        companyNameTextField.font = UIFont(name: ProjectCloseFonts.addLeadViewControllerCompanyNameFont, size: 20.0)
        companyNameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_vc_company_name_placeholder", value: "e.g. Foo Company", comment: "Add Lead VC Company Name Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyNameTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        companyNameTextField.delegate = self

        self.view.addSubview(companyNameTextField)

        self.view.addConstraint(companyNameTextField.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(companyNameTextField.widthAnchor.constraint(equalTo: (companyNameTextField.superview?.widthAnchor)!))
        self.view.addConstraint(companyNameTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupCompanyDescriptionLabel() {
        companyDescriptionLabel = UILabel()
        companyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        companyDescriptionLabel.text = NSLocalizedString("add_lead_vc_company_description_label_title", value: " Company Description",comment: "Add Lead VC Company Description Label Title")
        companyDescriptionLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyDescriptionTitleColor)
        companyDescriptionLabel.font = UIFont(name: ProjectCloseFonts.addLeadViewControllerCompanyDescriptionFont, size: 20.0)
        companyDescriptionLabel.sizeToFit()

        self.view.addSubview(companyDescriptionLabel)

        self.view.addConstraint(companyDescriptionLabel.topAnchor.constraint(equalTo: companyNameTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(companyDescriptionLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupCompanyDescriptionTextField() {
        companyDescriptionTextField = UIOffsetUITextField()
        companyDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false

        companyDescriptionTextField.keyboardType = .asciiCapable
        companyDescriptionTextField.autocorrectionType = .no
        companyDescriptionTextField.autocapitalizationType = .none
        companyDescriptionTextField.textColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyDescriptionTextFieldTitleColor)
        companyDescriptionTextField.font = UIFont(name: ProjectCloseFonts.addLeadViewControllerCompanyDescriptionFont, size: 20.0)
        companyDescriptionTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_lead_vc_company_description_placeholder", value: "e.g. Awesome Company!!!", comment: "Add Lead VC Company Description Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyDescriptionTitleColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addLeadViewControllerTextFieldPlaceholderFont, size: 20.0)!])

        companyDescriptionTextField.delegate = self

        self.view.addSubview(companyDescriptionTextField)

        self.view.addConstraint(companyDescriptionTextField.topAnchor.constraint(equalTo: companyDescriptionLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(companyDescriptionTextField.widthAnchor.constraint(equalTo: (companyDescriptionTextField.superview?.widthAnchor)!))
        self.view.addConstraint(companyDescriptionTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupCompanyAddressLabel() {
        companyAddressLabel = UILabel()
        companyAddressLabel.translatesAutoresizingMaskIntoConstraints = false

        companyAddressLabel.text = NSLocalizedString("add_lead_vc_company_address_label_title", value: " Company Address",comment: "Add Lead VC Company Address Label Title")
        companyAddressLabel.textColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyAddressTitleColor)
        companyAddressLabel.font = UIFont(name: ProjectCloseFonts.addLeadViewControllerCompanyAddressFont, size: 20.0)
        companyAddressLabel.sizeToFit()

        self.view.addSubview(companyAddressLabel)

        self.view.addConstraint(companyAddressLabel.topAnchor.constraint(equalTo: companyDescriptionTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(companyAddressLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupCompanyAddressTextView() {
        companyAddressTextView = UITextView()
        companyAddressTextView.translatesAutoresizingMaskIntoConstraints = false

        companyAddressTextView.keyboardType = .asciiCapable
        companyAddressTextView.autocorrectionType = .default
        companyAddressTextView.autocapitalizationType = .sentences
        companyAddressTextView.textColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyAddressTitleColor)
        companyAddressTextView.font = UIFont(name: ProjectCloseFonts.addLeadViewControllerTextFieldPlaceholderFont, size: 20.0)

        companyAddressTextView.text = companyAddressTextViewPlaceholderString
        companyAddressTextView.delegate = self

        self.view.addSubview(companyAddressTextView)

        self.view.addConstraint(companyAddressTextView.topAnchor.constraint(equalTo: companyAddressLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(companyAddressTextView.widthAnchor.constraint(equalTo: (companyAddressTextView.superview?.widthAnchor)!))
        self.view.addConstraint(companyAddressTextView.heightAnchor.constraint(equalToConstant: 120.0))
    }

    func setupAddLeadButton() {
        addLeadButton = UIButton()
        addLeadButton.translatesAutoresizingMaskIntoConstraints = false

        addLeadButton.setTitle(NSLocalizedString("add_lead_vc_add_lead_button_title", value: "ADD LEAD", comment: "Add Lead VC Add Lead Button Title"), for: .normal)
        addLeadButton.setTitleColor(UIColor(hexString: ProjectCloseColors.addLeadViewControllerAddLeadButtonTitleColor), for: .normal)
        addLeadButton.backgroundColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerAddLeadButtonBackgroundColor)
        addLeadButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.addLeadViewControllerAddLeadButtonFont, size: 20.0)
        addLeadButton.sizeToFit()

        self.view.addSubview(addLeadButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[addLeadButton(>=50)]-100-|", metrics: nil, views: ["addLeadButton" : addLeadButton]))
        self.view.addConstraint(addLeadButton.topAnchor.constraint(equalTo: companyAddressTextView.bottomAnchor, constant: 50.0))
        self.view.addConstraint(addLeadButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(addLeadButton.centerXAnchor.constraint(equalTo: (addLeadButton.superview?.centerXAnchor)!))

        addLeadButton.addTarget(self, action: #selector(AddLeadViewController.addLeadButtonPressed(_:)), for: .touchUpInside)
    }

    func backButtonPressed(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }


    func setupRealm() {
        realm = try! Realm()
    }

    func addLeadButtonPressed(_ sender: UIButton) {
        setupRealm()

        let newLead = Lead()
        newLead.leadId = UUID().uuidString
        newLead.companyName = companyNameTextField.text!
        newLead.companyDescription = companyDescriptionTextField.text!
        newLead.companyAddress = companyAddressTextView.text!

        newLead.createdBy = realm.object(ofType: User.self, forPrimaryKey: "raj@diskodev.com")
        newLead.createdOn = NSDate()
        newLead.status = "Potential"

        let companyNameWords = companyNameTextField.text!.components(separatedBy: " ")
        if companyNameWords.count > 1 {
            newLead.shortIdentifier = String(describing: companyNameWords[0].characters.first!) + String(describing: companyNameWords[1].characters.first!)
            newLead.shortIdentifier = newLead.shortIdentifier.uppercased()
        } else {
            newLead.shortIdentifier = String(describing: companyNameWords[0].characters.first!)
            newLead.shortIdentifier = newLead.shortIdentifier.uppercased()
        }

        try! realm.write {
            realm.add(newLead, update: true)
        }

        // Save messages

        addDelegate.didFinishAddingLead(sender: self)

        let leadDetailsContainerViewController = LeadDetailsContainerViewController(leadId: newLead.leadId)
        leadDetailsContainerViewController.changeDelegate = changeDelegate

        let leadDetailsPagingMenuViewController = makeLeadDetailsPagingViewController(leadId: newLead.leadId)

        leadDetailsContainerViewController.addChildViewController(leadDetailsPagingMenuViewController)
        leadDetailsContainerViewController.view.addSubview(leadDetailsPagingMenuViewController.view)

        leadDetailsPagingMenuViewController.didMove(toParentViewController: self)

        self.navigationController?.pushViewController(leadDetailsContainerViewController, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !companyAddressTextViewEdited {
            textView.text = nil
            textView.font? = UIFont(name: ProjectCloseFonts.addLeadViewControllerCompanyAddressFont, size: 20.0)!
            textView.textColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyAddressTextFieldTitleColor)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = companyAddressTextViewPlaceholderString
            textView.font? = UIFont(name: ProjectCloseFonts.addLeadViewControllerTextFieldPlaceholderFont, size: 20.0)!
            textView.textColor = UIColor(hexString: ProjectCloseColors.addLeadViewControllerCompanyAddressTitleColor)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning : AddLeadViewController")
    }

}
