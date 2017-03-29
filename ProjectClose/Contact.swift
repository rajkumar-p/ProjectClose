//
//  Contact.swift
//  ProjectClose
//
//  Created by raj on 06/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    dynamic var contactId: String!
    dynamic var leadId: String!

    dynamic var name: String!
    dynamic var email: String!
    dynamic var phone: String!

    override static func indexedProperties() -> [String] {
        return ["contactId", "leadId"]
    }

    override static func primaryKey() -> String? {
        return "contactId"
    }
}
