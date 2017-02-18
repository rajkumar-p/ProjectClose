//
//  TextMessage.swift
//  ProjectClose
//
//  Created by raj on 08/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class TextMessage: Object {
    dynamic var message: String!
    dynamic var dateTime: Date!

    dynamic var from: String!
    dynamic var to: String!
}
