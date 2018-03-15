//
//  Answer.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 11..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class Answer: NSObject {
    var answer: String!
    var value: Int!

    init(_ answer: String, _ value: Int) {
        super.init()
        self.answer = answer
        self.value = value
    }
}
