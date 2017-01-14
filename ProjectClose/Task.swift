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
    var taskId: Int!
    dynamic var taskDescription: String = ""
    var leadId: Int!
    var expiryDateTime: NSDate!
    
    var createdBy: User!
    var assignedTo: User!
}
