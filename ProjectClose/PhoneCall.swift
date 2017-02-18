//
//  PhoneCall.swift
//  ProjectClose
//
//  Created by raj on 08/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import RealmSwift

class PhoneCall: Object {
    dynamic var from: String!
    dynamic var to: String!

    dynamic var startTime: Date!
    dynamic var endTime: Date!
}
