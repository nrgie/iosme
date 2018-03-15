//
//  ProgressView.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 10..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit

class ProgressView : UIView {
    
    var contentView : UIView?
    var dayNumber: Int = 6
    var program: Program!
    @IBOutlet weak var currentDayContainer: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var progressView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var programProgressPercentLabel: UILabel!
    @IBOutlet weak var weightMeasureLabel: UILabel!
    @IBOutlet weak var dailyProgramLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
        //let frame = self.indicatorView.frame
        //self.indicatorView.layer.anchorPoint = CGPoint(x: (frame.size.height / frame.size.width * 0.5), y: 0.5) // Anchor points are in unit space
        //self.indicatorView.frame = frame; // Moving the anchor point moves the layer's position, this is a simple way to re-set
        self.rotateToAngle()
        //self.perform(#selector(animate), with: nil, afterDelay: 2.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.rotateToAngle()
    }
    
    func animate() {
        self.dayNumber += 1
        if self.dayNumber > 42 {
            self.dayNumber = 1
        }
        rotateToAngle()
        self.perform(#selector(animate), with: nil, afterDelay: 0.4)
    }
    
    func rotateToAngle () {
        var angle = CGFloat(360.0 / 42.0 * Double(self.dayNumber) * Double.pi / 180.0)
        self.indicatorView.transform = CGAffineTransform(rotationAngle: angle); // Performs the rotation
        self.currentDayContainer.transform = CGAffineTransform(rotationAngle: -angle);
        self.progressView.image = UIImage(named: String(format: "mobil-app-cirlcle-%02dday", self.dayNumber))
        self.dayLabel.text = "\(self.dayNumber)."
        self.dailyProgramLabel.text = "Profile.Progress.DayTitle".localizeWithFormat(args: self.dayNumber)
        self.programProgressPercentLabel.text = "\(Int((Float(self.dayNumber)/42.0) * 100))%"
       
        let center = CGPoint(x: self.frame.size.width/2 , y: self.frame.size.height/2)
        let radius : CGFloat = self.frame.size.height * 0.355
        let count = 42
        
        angle = CGFloat(1.545 * Double.pi)
        let step = CGFloat(2 * Double.pi) / CGFloat(count)
        for index in 1 ..< count + 1  {
            let x = cos(angle) * radius + center.x
            let y = sin(angle) * radius + center.y
            self.viewWithTag(1432+index)?.removeFromSuperview()
            let label = UILabel()
            label.text = "\(index)"
            label.tag = 1432+index
            label.font = Theme.shared.robotoFont(size: 8)
            label.textColor = UIColor.black
            label.frame.size.width = 13.0
            label.frame.size.height = 13.0
            label.textAlignment = .center
            label.textColor = .white
            if index < self.dayNumber {
                if program != nil {
                    if program.completedDays.contains(index) {
                        label.backgroundColor = UIColor(netHex: 0x8FCDAC)
                    } else {
                        label.backgroundColor = UIColor(netHex: 0xF2685F)
                    }
                }
            } else {
                label.backgroundColor = UIColor(netHex: 0xbce3de)
            }
            self.sendSubview(toBack: label)
            label.layer.masksToBounds = true
            label.layer.cornerRadius = label.frame.size.height / 2.0
            label.frame.origin.x = x - label.frame.midX
            label.frame.origin.y = y - label.frame.midY
            
            if index != self.dayNumber {
                self.addSubview(label)
            }
            angle += step 
        }
    }
    
    func loadXib() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)       
    }
    
    func loadViewFromNib() -> UIView! {
        guard let view = Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)?.first as? UIView else {
            return nil
        }
        self.addSubview(view)
        return view
    }
}
