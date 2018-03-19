//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class SettingAvatarView: UIView {
    
    
    @IBAction func go(_ sender: Any) {
        
    }
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let contentView = Bundle.main.loadNibNamed("SettingAvatar", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        addSubview(contentView)
    }
    
    func fill(with item: Setting) {
        key.text = item.key
        value.text = item.value
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
