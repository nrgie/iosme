//
//  OAuthResponse.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 06..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import ObjectMapper

class OAuthResponse : BaseResponse {
    var accessToken: String!
    var expiresIn: Decimal!
    var tokenType: String!
    var scope: String?
    var refreshToken: String!
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
        tokenType <- map["token_type"]
        scope <- map["scope"]
        refreshToken <- map["refresh_token"]
    }
}
