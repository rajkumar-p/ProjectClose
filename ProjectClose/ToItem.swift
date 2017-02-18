//
//  ToItem.swift
//  ProjectClose
//
//  Created by raj on 14/02/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ToItem: Object {
    var toItem: String
    
    init(to: String) {
        self.toItem = to
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        self.toItem = ""
        super.init(realm: realm, schema: schema)
    }
    
    required init() {
        self.toItem = ""
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    func getStringRepresentation() -> String {
        return toItem
    }
}
