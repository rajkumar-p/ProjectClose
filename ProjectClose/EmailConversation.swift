//
//  EmailConversation.swift
//  ProjectClose
//
//  Created by raj on 13/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class EmailConversation: Object {
    dynamic var subject = "" {
        didSet {
            id = idValue()
        }
    }

    dynamic var leadId = "" {
        didSet {
            id = idValue()
        }
    }

    dynamic var id: String = ""

    var messages = List<EmailMessage>()
    dynamic var participants: String!

    override static func primaryKey() -> String? {
        return "id"
    }

    private func idValue() -> String {
        return "\(leadId) :: \(subject)"
    }
}
