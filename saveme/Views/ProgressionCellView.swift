//
//  ProgressionCellView.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 15..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ProgressionCellView: UICollectionViewCell {

    @IBOutlet weak var progressView: ProgressView!
    var program: Program?
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var programLabel: UILabel!
   
    func bind(to program: Program){
        self.program = program
        self.progressView.dayNumber = Int(program.currentDay)!
        let keys: Array<String>
        let weightChange: Double
        if self.program!.weights == nil {
            weightChange = 0
        } else {
            keys = self.program!.weights.allKeys as! Array<String>
            weightChange = (self.program!.weights.object(forKey: keys.first!) as! Double) - (self.program!.weights.object(forKey: keys.last!) as! Double)

        }

        progressView.weightMeasureLabel.text = "\(self.getSignFor(weightChange))\(abs(weightChange))kg"
        progressView.program = program
        iconImageView.contentMode = .scaleAspectFit
        sponsorImageView.contentMode = .scaleAspectFit
        iconImageView.sd_setImage(with: URL(string: program.image)!)
        if program.sponsor != nil {
            sponsorImageView.sd_setImage(with: URL(string: program.sponsor)!)
        } else {
            sponsorImageView.image = nil
        }
        programLabel.text = "ProgressionCell.Title".localized//program.name
        sponsorImageView.isHidden = true
    }
    
    func getSignFor(_ number: Double) -> String {
        if number > 0.0 {
            return "+"
        } else if number < 0.0 {
            return "-"
        }
        return ""
    }
    
}
