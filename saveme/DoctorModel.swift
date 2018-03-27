//
//  ProtectedModel.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 22..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import ObjectMapper

class DoctorModel: Mappable {
    
    var name: String!
    var email: String!
    var phone: String!
    var special: String!
    var custom: String!

    required init?(map: Map) {
        //super.init(map: map)
    }
    
    init(_ name: String!, _ email: String!, _ phone: String!) {
        self.name = name
        self.email = email
        self.phone = phone
    }
    
    func mapping(map: Map) {
        //super.mapping(map: map)
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        special <- map["special"]
        custom <- map["custom"]
    }
    
}

