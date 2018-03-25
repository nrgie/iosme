//
//  Gmap.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 25..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Gmap {

   class Map {
            
            class var googleApiKey: String {
                return "AIzaSyAI4xfwJSScsWs1cKBTJCcxIaLg8iuLyfM"
            }
            /*
             StringBuilder googlePlacesUrl = new StringBuilder("https://maps.googleapis.com/maps/api/place/nearbysearch/json?");
             googlePlacesUrl.append("location=" + Global.user.lat + "," + Global.user.lng);
             googlePlacesUrl.append("&radius=" + PROXIMITY_RADIUS);
             googlePlacesUrl.append("&type=" + nearbyPlace);
             googlePlacesUrl.append("&sensor=true");
             googlePlacesUrl.append("&key=" + "AIzaSyAI4xfwJSScsWs1cKBTJCcxIaLg8iuLyfM");
             Log.e("getUrl", googlePlacesUrl.toString());
             
             */
            
            class func get(place: String) {
                
                let lat = AppDelegate.shared.lat
                let lng = AppDelegate.shared.lng
                
                let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=25000&location=\(lat),\(lng)&type=\(place)&sensors=true&key=\(googleApiKey)"
                
                print(url)
                
                Alamofire.request(url)
                    .responseJSON { response in
                        if let json = response.result.value as? [String: Any] {
                            print("JSON: \(json)")
                            let places = Array<GoogleAutocompleteJSONModel>(json: json["predictions"])
                            let autocomplete = places.flatMap{ $0.title}
                            print("!!!! \(autocomplete)")
                        }
                }
        }
    }
}

extension Array where Element: Mappable {
    
    init(json: Any?) {
        self.init()
        
        var result = [Element]()
        if let array = json as? [[String: Any]] {
            for item in array {
                if let profile = Element(JSON: item) {
                    result.append(profile)
                }
            }
        }
        self = result
    }
}

