//
//  PageIndicatorView.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 12..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class PageIndicatorView: UIView {
    
    @IBInspectable open var pageCount: Int = 3 {
        didSet {
            self.setNeedsDisplay()
            setup()
        }
    }
    
    @IBInspectable open var selectedPage: Int = 0 {
        didSet {
            self.setNeedsDisplay()
            for v in views {
                v.transform = CGAffineTransform.identity
                
                
                if views.index(of: v)! <= selectedPage*2 {
                    v.backgroundColor = UIColor.init(netHex: 0x49B3BD)
                    if let l = (v as? UILabel) {
                        l.textColor = .white
                    }
                } else {
                    v.backgroundColor = .white
                    if let l = (v as? UILabel) {
                        l.textColor = UIColor.init(netHex: 0x49B3BD)
                    }
                }
                
            }
            views[selectedPage*2].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    var views: Array<UIView> = Array<UIView>()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setup() {
        
      
        for v in self.views {
            v.removeFromSuperview()
        }
        
        views = Array<UIView>()
        let indicatorWidth = Double(self.frame.height)
        let spacingWidth = (Double(self.frame.width)-(Double(pageCount) * indicatorWidth))/Double(pageCount-1)
        var startX = 0.0
        for i in 0...(pageCount-1)*2 {
            let currentWidth = i%2==1 ? spacingWidth+indicatorWidth : indicatorWidth
            let currentHeight = i%2==1 ? 10.0 : indicatorWidth
            var v: UIView
            if i%2==1 {
                v = UIView(frame: CGRect(x:startX, y: (Double(self.frame.height)-currentHeight)/2.0, width: currentWidth, height: currentHeight))
            } else {
                v = UILabel(frame: CGRect(x:startX, y: (Double(self.frame.height)-currentHeight)/2.0, width: currentWidth, height: currentHeight))
            }
            startX = startX + currentWidth - (i%2==1 ? indicatorWidth/2.0 : currentWidth/2.0)
            views.append(v)
            
            if i%2 == 1 {
                if i <= selectedPage*2 {
                    v.backgroundColor = UIColor.init(netHex: 0x49B3BD)
                } else {
                    v.backgroundColor = .white
                }
            } else {
                let l: UILabel = v as! UILabel
                l.layer.cornerRadius = CGFloat(currentHeight/2.0)
                l.layer.masksToBounds = true
                l.textAlignment = .center
                l.text = "\(i/2+1)"
                l.font = UIFont.boldSystemFont(ofSize: CGFloat(currentHeight * Double(0.6)))
                if i <= selectedPage*2 {
                    l.backgroundColor = UIColor.init(netHex: 0x49B3BD)
                    l.textColor = .white
                } else {
                    l.backgroundColor = .white
                    l.textColor = UIColor.init(netHex: 0x49B3BD)
                }
            }
            
            if i != 0, i%2==1 {
                self.insertSubview(v, belowSubview: views[0])
            } else {
                self.addSubview(v)
            }

        }
        //stackView.updateConstraints()
        self.layoutIfNeeded()
        views[selectedPage*2].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

}
