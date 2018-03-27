//
//  ProtectedModel.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 22..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import ObjectMapper

class MedModel: Mappable {
    
    var name: String!
    var qty: String!
    var pic: String!

    required init?(map: Map) {
        //super.init(map: map)
    }
    
    init(_ name: String!, _ qty: String!) {
        self.name = name
        self.qty = qty
    }
    
    func mapping(map: Map) {
        //super.mapping(map: map)
        name <- map["name"]
        qty <- map["qty"]
        pic <- map["pic"]
    }
    
}

