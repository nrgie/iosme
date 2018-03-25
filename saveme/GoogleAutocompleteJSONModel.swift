//
//  GoogleAutocompleteJSONModel.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 25..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import ObjectMapper

class GoogleAutocompleteJSONModel: Mappable, CustomStringConvertible {
    
    public fileprivate(set) var placeId: String?
    public fileprivate(set) var reference: String?
    public fileprivate(set) var title: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        title                       <- map["description"]
        placeId                     <- map["place_id"]
        reference                   <- map["reference"]
    }
    
    var description: String {
        return "\(toJSON())"
    }
}
