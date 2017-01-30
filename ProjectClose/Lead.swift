//
//  Lead.swift
//  ProjectClose
//
//  Created by raj on 10/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class Lead: Object {
    dynamic var leadId: String = ""
    dynamic var companyName: String = ""
    dynamic var companyDescription: String = ""
    dynamic var companyAddress: String = ""
    dynamic var createdOn: NSDate!
    
    var tasks = List<Task>()
    dynamic var createdBy: User!
    dynamic var status: String!

    override static func indexedProperties() -> [String] {
        return ["leadId"]
    }

    override static func primaryKey() -> String? {
        return "leadId"
    }
}
