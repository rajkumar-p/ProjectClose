//
//  Opportunity.swift
//  ProjectClose
//
//  Created by raj on 07/03/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class Opportunity: Object {
    dynamic var opportunityId: String!
    dynamic var opportunityDescription: String = ""
    dynamic var leadId: String!
    dynamic var createdDate: Date!

    dynamic var createdBy: User!
    dynamic var assignedTo: User!

    dynamic var expiryDate: Date!

    dynamic var status: String!
    dynamic var value: Int = 0
    dynamic var confidence: Double = 0.0

    override static func indexedProperties() -> [String] {
        return ["opportunityId", "leadId"]
    }

    override static func primaryKey() -> String? {
        return "opportunityId"
    }
}
