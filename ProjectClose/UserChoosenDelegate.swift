//
//  UserChoosenDelegate.swift
//  ProjectClose
//
//  Created by raj on 01/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

protocol UserChoosenDelegate: class {
    func didChooseUser(sender: ChooseUserTableViewController, selectedUserEmail: String)
}
