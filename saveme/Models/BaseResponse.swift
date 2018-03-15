//
//  BaseResponse.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 06..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse : Mappable {
    
    var success: Bool? = false
    
    required init?(map: Map){
        
    }
    
    init?(){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
    }
}
