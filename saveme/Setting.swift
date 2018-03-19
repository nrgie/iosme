//
//  Setting.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 17..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import UIKit

class Setting: NSObject {

    var icon: String!
    var key: String!
    var value: String!
    var action: String!
    var type: String!
    var userfield: String!
    
    init(_ icon: String, _ key: String, _ value: String, _ action: String) {
        super.init()
        self.icon = icon
        self.key = key
        self.value = value
        self.action = action
        self.type = ""
        self.userfield = ""
    }
    
    init(_ icon: String, _ key: String, _ value: String, _ action: String, _ type: String, _ userfield: String) {
        super.init()
        self.icon = icon
        self.key = key
        self.value = value
        self.action = action
        self.type = type
        self.userfield = userfield
    }
}
