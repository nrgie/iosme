//
//  Question.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 11..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class Question: NSObject {
    var question: String!
    var answers: [Answer]!
    var program: String!

    init(question: String, answers: [Answer]!, program: String) {
        super.init()
        self.question = question
        self.answers = answers
        self.program = program
    }
}
