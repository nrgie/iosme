//
//  RestClient.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 05..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON
import ObjectMapper

protocol PageControllerDelegate {
    func pagesLoaded(pages: [Page], programId: String)
}

class RestClient {
    
    static let headers = ["Accept-Language": "hu"]
    static let commonErrorString = "Unknown server error"
    
    private static func handleError(data: Data, complitionBlock:  ((String) -> Void)?){
        /*
        do {
            if let errorMessage = try JSON(data: data)["message"].string {
                complitionBlock!(errorMessage)
            } else {
                complitionBlock!(commonErrorString)
            }
        } catch _ {
            
        }
        */
        
    }
    
    public static func performOAuthCall(urlString: String = "/login.php", method: HTTPMethod = .post, params: [String: Any], complitionBlock: ((String?, OAuthResponse?) -> Void)?) -> Void
    {
        let url = URL(string: Constants.EndPoints.OAuthApi + urlString)!
        Alamofire.request(url, method: .post, parameters: params).responseObject(keyPath: "", completionHandler: { (response: DataResponse<OAuthResponse>) in
            if response.result.isSuccess {
                let result: OAuthResponse = response.result.value!
                if result.refreshToken == nil {
                    handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                        complitionBlock!(errorMessage, nil)
                    })
                }else {
                    complitionBlock!(nil, result)
                }
            } else {
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
            }
        })
    }

    public static func loginCall(urlString: String = "/login.php", method: HTTPMethod = .post, params: [String: Any], complitionBlock: ((String?, UserData?) -> Void)?) -> Void
    {
        let url = URL(string: Constants.EndPoints.Api + urlString)!
        
        Alamofire.request(url, method: .post, parameters: params).responseObject(keyPath: "", completionHandler: { (response: DataResponse<UserData>) in
            
            //if response == nil {
                
                let result: UserData = response.value!
                complitionBlock!(nil, result)
            
            
                /*
                if result.refreshToken == nil {
                    handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                        complitionBlock!(errorMessage, nil)
                    })
                } else {
                    complitionBlock!(nil, result)
                }
 
            } else {
                
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
                
            }
              */
        })
    }

    
    
    public static func registrate(user_params: [String: Any], complitionBlock: ((String?) -> Void)?) -> Void
    {
        let url = URL(string: Constants.EndPoints.OAuthApi + "/register.php")!
        var headrs = Dictionary<String, String>()
        headrs["Content-Type"] = "application/x-www-form-urlencoded"
        //headers = headers.merged(with: self.headers)
        Alamofire.request(url, method: .post, parameters: user_params, headers: headrs).responseJSON { (response) in
/*
            let json = JSON(data: response.data!)
            print(json)
            if response.response?.statusCode == 406 {
                complitionBlock!(json["message"].string)
            } else if response.response?.statusCode == 200 {
                complitionBlock!(json["message"].string)
            } else {
                complitionBlock!(json["message"].string)
            }
 */
        }
    }
    
    public static func updateUser(userId: String, userParams: [String: Any], access_token: String, complitionBlock: ((String?, OAuthResponse?) -> Void)?) -> Void
    {
        let url = URL(string: Constants.EndPoints.OAuthApi + "/api.php?function=updateUser&access_token=\(access_token)&user_id=\(userId)")!
        Alamofire.request(url, method: .get, parameters: userParams).responseObject(keyPath: "", completionHandler: { (response: DataResponse<OAuthResponse>) in
            /*
            print(JSON(data: response.data!))
            if response.result.isSuccess {
                complitionBlock!(nil, response.result.value)
            } else {
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
            }
 */
        })
    }
    
    public static func getUser(accessToken: String, complitionBlock: ((String?, UserResponse?) -> Void)?) {
        let url = URL(string: Constants.EndPoints.OAuthApi + "/resource.php?format=json")!
        Alamofire.request(url, method: .get, parameters: ["access_token": accessToken]).responseObject(keyPath: "", completionHandler: { (response: DataResponse<UserResponse>) in
            //print(JSON(data: response.data!))
            if response.result.isSuccess {
                let result: UserResponse = response.result.value!
                complitionBlock!(nil, result)
            } else {
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
            }
        })
    }
    
    public static func getUserData(userId: String, accessToken: String, complitionBlock: ((String?, UserDataResponse?) -> Void)?) {
        let url = URL(string: Constants.EndPoints.OAuthApi + "/api.php?function=getUserData")!
        Alamofire.request(url, method: .get, parameters: ["user_id": userId,"access_token": accessToken]).responseObject(keyPath: "", completionHandler: { (response: DataResponse<UserDataResponse>) in
            if response.result.isSuccess {
                let result: UserDataResponse = response.result.value!
                complitionBlock!(nil, result)
                RestClient.getPrograms(accessToken: accessToken) {error, programs in
                    DataStore.shared.programs = programs
                }
                RestClient.loadFavourites(accessToken: accessToken, complitionBlock: { (error: String?, pages: [Page]?) in
                    if pages != nil {
                        DataStore.shared.favourites = pages
                    }
                })
            } else {
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
            }
        })
        
    }
    
    public static func getSubscriptions(userId: String,subscriptionType: String = "getUserSubscriptions", accessToken: String, complitionBlock: ((String?, [Subscription]?) -> Void)?) {
        let url = URL(string: Constants.EndPoints.OAuthApi + "/api.php")!
        Alamofire.request(url, method: .get, parameters: ["user_id": userId,"function":subscriptionType, "access_token": accessToken]).responseArray(keyPath: "userSubscriptions", completionHandler: { (response: DataResponse<[Subscription]>) in
            // debugPrint(response)
            if response.result.isSuccess {
                let result: [Subscription] = response.result.value!
                complitionBlock!(nil, result)
            } else {
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
            }
        })
    }
    
    public static func subscribe(for programId: Int, userId: String,subscriptionType: String = "setUserSubscriptions", intensity: Int, subscriptionDate: Int, accessToken: String, complitionBlock: ((String?, [Subscription]?) -> Void)?) {
        let url = URL(string: Constants.EndPoints.OAuthApi + "/api.php")!
        Alamofire.request(url, method: .get, parameters: ["program_id": programId,"subscription_date": subscriptionDate,"intensity": intensity,"user_id": userId,"function":subscriptionType, "access_token": accessToken]).responseArray(keyPath: "userSubscriptions", completionHandler: { (response: DataResponse<[Subscription]>) in
            //debugPrint(response)
            if response.result.isSuccess {
                let result: [Subscription] = response.result.value!
                complitionBlock!(nil, result)
            } else {
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
            }
        })
    }
    
    public static func getPrograms(accessToken: String, complitionBlock: ((String?, [Program]?)-> Void)?) {

        print(accessToken)
        
        let url = URL(string: Constants.EndPoints.WPApi + "wp-json/nep/v1/programs/\(accessToken)")!

        Alamofire.request(url, method: .get).responseArray(keyPath: "result", completionHandler: { (response: DataResponse<[Program]>) in
            //print(JSON(data: response.data!))
            if response.result.isSuccess {
                
                let result: [Program] = response.result.value!

                //AppDelegate.shared.registerForLocalNotification(day: trioday, runday: runday, url1:url1, url2:url2)
                
                complitionBlock!(nil, result)
                
            } else {
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
            }
        })
    }
    
    public static func sendDailySuccess(day: String, accessToken: String, complitionBlock: ((Bool?)-> Void)?) {
        let url = URL(string: Constants.EndPoints.WPApi + "/wp-json/nep/v1/daily-check")!
        var headrs = Dictionary<String, String>()
        /*
        headrs["Content-Type"] = "application/x-www-form-urlencoded"
        Alamofire.request(url, method: .post, parameters: ["accesstoken": accessToken, "day": day],headers: headrs).responseJSON { (response) in
            let json = JSON(data: response.data!)
            print(json)
            complitionBlock!(json["success"] == true)
        }
 */
    }
    
    public static func sendWeight(weight: String, day: String, accessToken: String, complitionBlock: ((Bool?)->Void)?){
        let url = URL(string: Constants.EndPoints.WPApi + "/wp-json/nep/v1/daily-weight")!
        var headrs = Dictionary<String, String>()
        /*
        headrs["Content-Type"] = "application/x-www-form-urlencoded"
        Alamofire.request(url, method: .post, parameters: ["accesstoken": accessToken, "day": day, "weight": weight], headers: headrs).responseJSON { (response) in
            let json = JSON(data: response.data!)
            complitionBlock!(json["success"] == true)
        }
 */
    }
    
    public static func loadPage(url: String, programId: String, delegate: PageControllerDelegate){
        /*
        Alamofire.request(url, method: .get).responseArray(keyPath: "result", completionHandler: { (response: DataResponse<[Page]>) in
            let json = JSON(data: response.data!)
            print(json)
            delegate.pagesLoaded(pages: response.result.value!, programId: programId)
        })
 */
    }
    
    public static func loadFavourites(accessToken: String, complitionBlock: ((String?, [Page]?) -> Void)?){
        /*
        Alamofire.request(Constants.EndPoints.WPApi + "/wp-json/nep/v1/favorite-recipes", method: .get, parameters: ["accesstoken":accessToken]).responseArray(keyPath: "result", completionHandler: { (response: DataResponse<[Page]>) in
            let json = JSON(data: response.data!)
            print(json)
            if response.result.isSuccess {
                let result: [Page] = response.result.value!
                complitionBlock!(nil, result)
            } else {
                // Nothing to do here
            }
        })
 */
    }
    
    public static func favouritePost(postId: String, accessToken: String, complitionBlock: ((Bool?)->Void)?){
        let url = URL(string: Constants.EndPoints.WPApi + "/wp-json/nep/v1/favorite-post")!
        var headrs = Dictionary<String, String>()
        /*
        headrs["Content-Type"] = "application/x-www-form-urlencoded"
        Alamofire.request(url, method: .post, parameters: ["accesstoken": accessToken, "post_id": postId], headers: headrs).responseJSON { (response) in
            let json = JSON(data: response.data!)
            complitionBlock!(json["success"] == true)
            RestClient.loadFavourites(accessToken: accessToken, complitionBlock: { (error: String?, pages: [Page]?) in
                if pages != nil {
                    DataStore.shared.favourites = pages
                }
            })
        }
 */
    }
    
    public static func unFavouritePost(postId: String, accessToken: String, complitionBlock: ((Bool?)->Void)?){
        let url = URL(string: Constants.EndPoints.WPApi + "/wp-json/nep/v1/favorite-post")!
        var headrs = Dictionary<String, String>()
        Alamofire.request(url, method: .delete, parameters: ["accesstoken": accessToken, "post_id": postId]).responseJSON { (response) in
                /*
            let json = JSON(data: response.data!)
            complitionBlock!(json["success"] == true)
            RestClient.loadFavourites(accessToken: accessToken, complitionBlock: { (error: String?, pages: [Page]?) in
                if pages != nil {
                    DataStore.shared.favourites = pages
                }
            })
 */
        }
    }
    
    public static func getRundays(accessToken: String, complitionBlock: ((String?, [RunDay]?)-> Void)?) {
        
        let url = URL(string: Constants.EndPoints.WPApi + "wp-json/nep/v1/running-data/\(accessToken)")!
        
        Alamofire.request(url, method: .get).responseArray(keyPath: "result.days", completionHandler: { (response: DataResponse<[RunDay]>) in
            //print(JSON(data: response.data!))
            if response.result.isSuccess {
                let result: [RunDay] = response.result.value!
                complitionBlock!(nil, result)
            } else {
                handleError(data: response.data!, complitionBlock: { (errorMessage: String) in
                    complitionBlock!(errorMessage, nil)
                })
            }
        })
    }
    
}

extension Dictionary {
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}


