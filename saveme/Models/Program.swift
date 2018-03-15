//
//  Program.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 14..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import ObjectMapper

class Program : BaseResponse {
    var id: String!
    var userSubscribed: Bool!
    var name: String!
    var slug: String!
    var date: String!
    var image: String!
    var sponsor: String!
    var sponsorTransparent: String!
    var background: String! = "#00000000"
    var backgroundHtml: String! = "#00000000"
    var intro: String!
    var status: String!
    var colNumb: Int!
    var active: Bool!
    var content: String!
    var allDays: Int = 42
    var currentDay: String!
    var completedDays: [Int]!
    var weights: NSDictionary!
    var ribbonBg: String!
    var position: String!
    var link1: String!
    var link2: String!
    var nextlink1: String!
    var nextlink2: String!
    var finished: Bool!
    
    required init?(map: Map) {
        super.init(map: map)
        id = map.JSON["id"] as! String

    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        currentDay <- map["currentday"]
        completedDays <- map["completed_days"]
        weights <- map["weights"]
        active <- map["active"]
        name <- map["name"]
        image <- map["image"]
        background <- map["background"]
        intro <- map["intro"]
        sponsor <- map["sponsor"]
        slug <- map["slug"]
        ribbonBg <- map["ribbon_bg"]
        sponsorTransparent <- map["sponsor_transparent"]
        position <- map["position"]
        link1 <- map["url_1"]
        link2 <- map["url_2"]
        nextlink1 <- map["nextday_url_1"]
        nextlink2 <- map["nextday_url_2"]
        finished <- map["finished"]
    }
    
}
