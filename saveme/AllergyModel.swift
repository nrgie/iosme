//
//  ProtectedModel.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 22..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import ObjectMapper

class AllergyModel: Mappable {
    
    var name: String!
    var hu: String!
    var en: String!
    var de: String!
    var key: String!
    var checked: Bool!

    required init?(map: Map) {
        //super.init(map: map)
    }
    
    func mapping(map: Map) {
        //super.mapping(map: map)
        name <- map["name"]
        en <- map["en"]
        de <- map["de"]
        hu <- map["hu"]
        checked <- map["checked"]
    }
    
}

