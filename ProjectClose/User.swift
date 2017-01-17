//
//  User.swift
//  ProjectClose
//
//  Created by raj on 10/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    dynamic var email: String = ""
    dynamic var name: String = ""
    dynamic var createdOn: NSDate!

    override static func indexedProperties() -> [String] {
        return ["email"]
    }

    override static func primaryKey() -> String? {
        return "email"
    }
}
