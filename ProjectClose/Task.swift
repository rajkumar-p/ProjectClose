//
//  Task.swift
//  ProjectClose
//
//  Created by raj on 10/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    var taskId: String!
    dynamic var taskDescription: String = ""
    var leadId: String!
    var createdDate: NSDate!
    
    var createdBy: User!
    var assignedTo: User!

    var closed: Bool = false
    var closedDate: NSDate!

    var expiryDate: NSDate!

    override static func indexedProperties() -> [String] {
        return ["taskId", "leadId"]
    }

    override static func primaryKey() -> String? {
        return "taskId"
    }
}
