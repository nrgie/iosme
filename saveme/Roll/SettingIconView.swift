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
        let v = DataStore.shared.userData?.safe(key: item.action) as? String
        
        if v == "" {
            value.text = item.value
        } else {
            value.text = v
        }
        
        avatar.image = UIImage(named:item.icon!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
