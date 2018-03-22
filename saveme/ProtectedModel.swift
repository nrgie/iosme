//
//  ProtectedModel.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 22..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import ObjectMapper

class ProtectedModel: Mappable {
    
    var name: String!
    var email: String!
    var lat: String!
    var lng: String!

    required init?(map: Map) {
        //super.init(map: map)
    }
    
    func mapping(map: Map) {
        //super.mapping(map: map)
        name <- map["name"]
        email <- map["email"]
        lat <- map["lat"]
        lng <- map["lng"]
    }
    
}

