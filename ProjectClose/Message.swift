//
//  Message.swift
//  ProjectClose
//
//  Created by raj on 08/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class Message: Object {
    dynamic var messageId: String!
    dynamic var leadId: String!

    dynamic var messageType: String!
    dynamic var emailConversation: EmailConversation!
    dynamic var phoneCall: PhoneCall!
    dynamic var textMessage: TextMessage!

    override static func indexedProperties() -> [String] {
        return ["messageId", "leadId"]
    }
    
    override static func primaryKey() -> String? {
        return "messageId"
    }
}

enum MessageType: String {
    case Text = "TEXT", Phone = "PHONE", Email = "EMAIL"
}
