
import Foundation
import ObjectMapper

class UserResponse: BaseResponse {
    
    var userId: String!
    var userName: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userId <- map["user_id"]
        userName <- map["user_name"]
        firstName <- map["user_first_name"]
        lastName <- map["user_last_name"]
        email <- map["user_email"]
    }
}
