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
    var leadId: Int!
    dynamic var companyName: String = ""
    dynamic var companyDescription: String = ""
    
    var tasks = List<Task>()
}
