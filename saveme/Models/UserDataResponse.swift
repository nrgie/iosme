//
//  UserDataResponse.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 06..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import ObjectMapper

class UserDataResponse : BaseResponse {
    var status: String!
    var message: String!
    var userData: [UserData]!
    var userSubscriptions: [Subscription]!
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        status <- map["status"]
        message <- map["message"]
        userData <- map["userData"]
        userSubscriptions <- map["userSubscriptions"]
    }
}
