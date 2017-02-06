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
    dynamic var taskId: String!
    dynamic var taskDescription: String = ""
    dynamic var leadId: String!
    dynamic var createdDate: Date!
    
    dynamic var createdBy: User!
    dynamic var assignedTo: User!

    dynamic var closed: Bool = false
    dynamic var closedDate: Date!

    dynamic var expiryDate: Date!

    override static func indexedProperties() -> [String] {
        return ["taskId", "leadId"]
    }

    override static func primaryKey() -> String? {
        return "taskId"
    }
}
