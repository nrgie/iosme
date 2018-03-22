//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class SettingIconView: UIView {
    

    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let contentView = Bundle.main.loadNibNamed("SettingIcon", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: Setting) {
        key.text = item.key
        value.text = item.value
        avatar.image = UIImage(named:item.icon!)
        
        if item.value == "" {
            let of = key.frame
            key.frame = CGRect(x:of.minX, y:0, width:of.width, height:100)
            key.baselineAdjustment = .alignCenters
            print("-----")
            print(key.frame)
            print("-----")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
