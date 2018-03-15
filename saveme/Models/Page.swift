//
//  Page.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 15..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import ObjectMapper

class Page: BaseResponse {
    
    var id: String!
    var content: String!
    var title: String!
    var name: String!
    
   
    required init?(map: Map) {
        super.init(map: map)
        id = (map.JSON["ID"] as! NSNumber).stringValue 
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        content <- map["post_content"]
        title <- map["post_title"]
        name <- map["post_name"]
    }
    
}
