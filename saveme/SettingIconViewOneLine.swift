//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class SettingIconViewOneLine: UIView {
    

    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("SettingIconOne", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
        
    }
    
    func fill(with item: Setting) {
        key.text = item.key
        avatar.image = UIImage(named:item.icon!)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
