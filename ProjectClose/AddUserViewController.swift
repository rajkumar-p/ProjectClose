//
//  AddUserViewController.swift
//  ProjectClose
//
//  Created by raj on 15/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

class AddUserViewController: UIViewController, UITextFieldDelegate {
    var nameLabel: UILabel!
    var nameTextField: UIOffsetUITextField!

    var emailLabel: UILabel!
    var emailTextField: UIOffsetUITextField!

    var addUserButton: UIButton!

    var realm: Realm!

    weak var delegate: AddUserDelegate?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTitle()
        setupView()

        setupLeftBarButton()
//        setupRightBarButton()

        setupNameLabel()
        setupNameTextField()
        setupEmailLabel()
        setupEmailTextField()
        setupAddUserButton()
    }

    func initTitle() {
        self.title = NSLocalizedString("add_users_vc_title", value: "Add User", comment: "Add User VC Title")
    }

    func setupView() {
        self.view.backgroundColor = .white
    }

    func setupLeftBarButton() {
        let backButtonImage = UIImage(named: ProjectCloseStrings.allViewControllerBackButtonImageName)?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(AddUserViewController.backButtonPressed(_:)))
    }

    func setupRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }

    func backButtonPressed(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.text = NSLocalizedString("add_user_vc_name_label_title", value: " Name",comment: "Add User VC Name Label Title")
        nameLabel.textColor = UIColor(hexString: ProjectCloseColors.addUserViewControllerNameLabelTitleColor)
        nameLabel.font = UIFont(name: ProjectCloseFonts.addUserViewControllerNameLabelFont, size: 20.0)
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
        nameTextField.font = UIFont(name: ProjectCloseFonts.addUserViewControllerNameTextFieldFont, size: 20.0)
        nameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_user_vc_name_placeholder", value: "e.g. John Doe", comment: "Add User VC Name Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addUserViewControllerNameTextFieldPlaceholderColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addUserViewControllerNamePlaceholderFieldFont, size: 20.0)!])

        nameTextField.delegate = self

        self.view.addSubview(nameTextField)

        self.view.addConstraint(nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(nameTextField.widthAnchor.constraint(equalTo: (nameTextField.superview?.widthAnchor)!))
        self.view.addConstraint(nameTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false

        emailLabel.text = NSLocalizedString("add_user_vc_email_label_title", value: " Email",comment: "Add User VC Email Label Title")
        emailLabel.textColor = UIColor(hexString: ProjectCloseColors.addUserViewControllerEmailLabelTitleColor)
        emailLabel.font = UIFont(name: ProjectCloseFonts.addUserViewControllerEmailLabelFont, size: 20.0)
        emailLabel.sizeToFit()

        self.view.addSubview(emailLabel)

        self.view.addConstraint(emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20.0))
        self.view.addConstraint(emailLabel.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupEmailTextField() {
        emailTextField = UIOffsetUITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.font = UIFont(name: ProjectCloseFonts.addUserViewControllerEmailTextFieldFont, size: 20.0)
        emailTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("add_user_vc_email_placeholder", value: "e.g. john.doe@example.com", comment: "Add User VC Email Placeholder"),
                attributes: [NSForegroundColorAttributeName : UIColor(hexString: ProjectCloseColors.addUserViewControllerEmailTextFieldPlaceholderColor)!,
                             NSFontAttributeName : UIFont(name: ProjectCloseFonts.addUserViewControllerEmailPlaceholderFieldFont, size: 20.0)!])

        emailTextField.delegate = self

        self.view.addSubview(emailTextField)

        self.view.addConstraint(emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5.0))
        self.view.addConstraint(emailTextField.widthAnchor.constraint(equalTo: (emailTextField.superview?.widthAnchor)!))
        self.view.addConstraint(emailTextField.heightAnchor.constraint(equalToConstant: 40.0))
    }

    func setupAddUserButton() {
        addUserButton = UIButton()
        addUserButton.translatesAutoresizingMaskIntoConstraints = false

        addUserButton.setTitle(NSLocalizedString("add_user_vc_add_user_button_title", value: "ADD USER", comment: "Add User VC Add User Button Title"), for: .normal)
        addUserButton.setTitleColor(UIColor(hexString: ProjectCloseColors.addUserViewControllerAddUserButtonTitleColor), for: .normal)
        addUserButton.backgroundColor = UIColor(hexString: ProjectCloseColors.addUserViewControllerAddUserButtonBackgroundColor)
        addUserButton.titleLabel?.font = UIFont(name: ProjectCloseFonts.addUserViewControllerAddUserButtonTitleFont, size: 20.0)
        addUserButton.sizeToFit()

        self.view.addSubview(addUserButton)

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[addUserButton(>=50)]-100-|", metrics: nil, views: ["addUserButton" : addUserButton]))
        self.view.addConstraint(addUserButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50.0))
        self.view.addConstraint(addUserButton.heightAnchor.constraint(equalToConstant: 40.0))
        self.view.addConstraint(addUserButton.centerXAnchor.constraint(equalTo: (addUserButton.superview?.centerXAnchor)!))

        addUserButton.addTarget(self, action: #selector(AddUserViewController.addUserButtonPressed(_:)), for: .touchUpInside)
    }

    func addUserButtonPressed(_ sender: UIButton) {
        setupRealm()

        let userToBeWritted = User()
        userToBeWritted.name = nameTextField.text!
        userToBeWritted.email = emailTextField.text!
        userToBeWritted.createdOn = NSDate()

        try! realm.write {
            realm.add(userToBeWritted, update: true)
        }

        print("AddUserViewController - Saved data")
        delegate?.didFinishAddingUser(sender: self)

        let _ = self.navigationController?.popViewController(animated: true)
    }

    func setupRealm() {
        realm = try! Realm()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Memory warning - AddUserViewController")
    }

}
