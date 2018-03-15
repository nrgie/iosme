//
//  DataStore.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation

class DataStore {
    
    static let shared: DataStore = {
        let instance = DataStore()
        return instance
    }()
    
    var userData: UserData?
    var subscriptions: [Subscription]?
    var programs: [Program]?
    var favourites: [Page]?
    
    var runSubscribed: Bool = false
    
    private func persist(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    private func readValue(for key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    public func getAccessToken() -> String? {
        return self.readValue(for: Constants.DataKeys.AccessTokenKey) as? String
    }
    
    public func setAccessToken(token: String) {
        self.persist(value: token, key: Constants.DataKeys.AccessTokenKey)
    }
    
    public func getUserId() -> String? {
        return self.readValue(for: Constants.DataKeys.UserIdKey) as? String
    }
    
    public func setUserId(userId: String) {
        self.persist(value: userId, key: Constants.DataKeys.UserIdKey)
    }
    
    public func clearData(){
        let clearableKeys: [String] = [Constants.DataKeys.AccessTokenKey, Constants.DataKeys.UserIdKey]
        clearableKeys.forEach { (key: String) in
            UserDefaults.standard.removeObject(forKey: key)
        }
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
        self.userData = nil
        self.subscriptions = nil
        self.programs = nil
        self.favourites = nil
    }
    
    public func dailyProgramURL (for day: String) -> [String: String] {
        var queries: [String: String] = [String: String]()
        self.programs?.filter { $0.active }.forEach({ (program: Program) in
            var query: String = Constants.EndPoints.WPApi + "/wp-json/nep/v1/posts-by-tags/" + day + "-nap"
            query += "," + program.slug
            if program.slug == "mozgas" {
                self.subscriptions?.forEach({ (subscription: Subscription) in
                    if program.id == subscription.programId {
                        if(subscription.intensity == "1") {
                            query += ",inaktiv"
                        } else if(subscription.intensity == "2") {
                            query += ",kozepesen-aktiv"
                        } else if(subscription.intensity == "3") {
                            query += ",aktiv"
                        }
                    }
                })
            }
            queries[program.id] = query
        })
        return queries
    }
}
