//
//  AnswersCell.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 11..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit
import SnapKit

class AnswersCell: UICollectionViewCell {
    var question: Question! {
        didSet {
            commonInit()
        }
    }
    
    func commonInit() {
        answer1Button?.isEnabled = true
        answer2Button?.isEnabled = true
        answer3Button?.isEnabled = true
        answer4Button?.isEnabled = true

        guard question != nil else {
            return
        }
        if (question?.answers?.count)! >= 2 {
            answer1Button?.setTitle("\(question.answers[0].answer!)", for: UIControlState())
            answer2Button?.setTitle("\(question.answers[1].answer!)", for: UIControlState())
            if question.answers.count == 4 {
                answer3Button?.setTitle("\(question.answers[2].answer!)", for: UIControlState())
                answer4Button?.setTitle("\(question.answers[3].answer!)", for: UIControlState())
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    @IBOutlet var answer1Button: UIButton?
    @IBOutlet var answer2Button: UIButton?
    @IBOutlet var answer3Button: UIButton?
    @IBOutlet var answer4Button: UIButton?

    @IBAction func answerSelected(_ sender: UIButton) {
        answer1Button?.isEnabled = false
        answer2Button?.isEnabled = false
        answer3Button?.isEnabled = false
        answer4Button?.isEnabled = false

        NotificationCenter.default.post(name: Constants.Notifications.AnswerSelectedNotification, object: ["selectedIndex":sender.tag,"question":question])
    }
    
}
