//
//  Intensity.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 15..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class Intensity: NSObject {
    var intensityId: String!
    var min: Int!
    var max: Int!
    var name: String!
    var slug: String!
    var value: Int = 0

    init(_ intensityId: String, _ min: Int, _ max: Int, _ name: String, _ slug: String) {
        super.init()
        self.intensityId = intensityId
        self.min = min
        self.max = max
        self.name = name
        self.slug = slug
    }
}
