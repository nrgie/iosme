//
//  ProtectedModel.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 22..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import ObjectMapper

class LangModel: Mappable {
    
    var name: String!
    var checked: Bool!

    required init?(map: Map) {
        //super.init(map: map)
    }
    
    init(_ name:String!, _ checked: Bool!) {
        self.name = name
        self.checked = checked
    }
    
    func mapping(map: Map) {
        //super.mapping(map: map)
        name <- map["name"]
        checked <- map["checked"]
    }
    
}

