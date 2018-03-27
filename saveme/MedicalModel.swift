//
//  ProtectedModel.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 22..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import ObjectMapper

class MedicalModel: Mappable {
    
    var name: String!
    var date: String!

    required init?(map: Map) {
        //super.init(map: map)
    }
    
    init(_ name: String!, _ date: String!) {
        self.name = name
        self.date = date
    }
    
    func mapping(map: Map) {
        //super.mapping(map: map)
        name <- map["name"]
        date <- map["date"]
    }
    
}

