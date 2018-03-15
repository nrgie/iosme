//
//  RunDay.swift
//  eletmodvaltok
//
//  Created by Tibi on 2017. 06. 25..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import ObjectMapper

class RunDay : BaseResponse {
    var content: String!
    var excerpt: String!
    var extra_url1: String!
    var extra_url1_text: String!
    var extra_url2: String!
    var extra_url2_text: String!
    var img: String!
    var title: String!
    var url: String!
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        content <- map["content"]
        excerpt <- map["excerpt"]
        extra_url1 <- map["extra_url1"]
        extra_url1_text <- map["extra_url1_text"]
        extra_url2 <- map["extra_url2"]
        extra_url2_text <- map["extra_url2_text"]
        title <- map["title"]
        img <- map["img"]
        url <- map["url"]
    }
    
}
