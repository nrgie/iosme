//
//  CustomCalendar.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 11..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class CustomCalendar: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        var weekSubviews = [UIStackView]()
        for i in 1...6 {
            
            var daySubviews = [UIButton]()
            for j in 1...7 {
                let v = UIButton()
                v.backgroundColor = UIColor(netHex: 0xcccccc)
                
                let dayNumber = calculateDay(row: i, col: j)
                v.setTitle("\(dayNumber)", for: UIControlState())
                v.setTitleColor(.lightGray, for: UIControlState())
                v.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
                v.tag = dayNumber
                v.addTarget(self, action: #selector(CustomCalendar.dayTapped(_:)), for: .touchUpInside)
                daySubviews.append(v)
            }
            let week: UIStackView = UIStackView(arrangedSubviews: daySubviews)
            week.axis = .horizontal
            week.distribution = .fillEqually
            week.spacing = 5.0
            weekSubviews.append(week)
            
            
        }
        
        let verticalLayout: UIStackView = UIStackView(arrangedSubviews: weekSubviews)
        verticalLayout.frame = self.bounds
        
        
        verticalLayout.axis = .vertical
        verticalLayout.distribution = .fillEqually
        verticalLayout.spacing = 5.0
        self.addSubview(verticalLayout)
        verticalLayout.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalTo(self)
        }
        self.layoutIfNeeded()
    }
    
    func calculateDay(row: Int, col: Int) -> Int {
        return ((row-1)*7)+col
    }
    
    func dayTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: Constants.Notifications.ShowDailyProgramNotification, object: NSNumber(value: sender.tag))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func updateFor(program: Program){
        print(program.weights)
        for i in 1...6 {
            for j in 1...7 {
                let dayNumber = calculateDay(row: i, col: j)
                if let numberView: UIButton = self.viewWithTag(dayNumber) as? UIButton{
                    if dayNumber <= Int(program.currentDay)! {
                        if program.completedDays.contains(dayNumber) {
                            numberView.backgroundColor = UIColor(netHex: 0x8FCDAC)
                            numberView.setTitleColor(.white, for: UIControlState())
                        } else {
                            numberView.backgroundColor = UIColor(netHex: 0xF2685F)
                            numberView.setTitleColor(.white, for: UIControlState())
                        }
                    } else {
                        numberView.backgroundColor = UIColor(netHex: 0xcccccc)
                    }
                }
                
            }
        }
    }
    
}
