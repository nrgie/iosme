//
//  Subscription.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 06..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import ObjectMapper

class Subscription : BaseResponse {
   
    var id: String!
    var userId: Decimal!
    var programId: String!
    var subscriptionDate: Date!
    var intensity: String!
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        userId <- map["user_id"]
        programId <- map["program_id"]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let dateString = map["subscription_date"].currentValue as? String, let _date = dateFormatter.date(from: dateString){
            subscriptionDate = _date
        }
        intensity <- map["intensity"]
    }
}
