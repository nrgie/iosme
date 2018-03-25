//
//  SettingView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class SettingView: UIView {

    
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    
    @IBAction func go(_ sender: Any) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let contentView = Bundle.main.loadNibNamed("Setting", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        addSubview(contentView)
    }
    
    func fill(with item: Setting) {
        key.text = item.key
        let v = DataStore.shared.userData?.safe(key: item.action)
        if value != nil {
            value.text = v as? String
        } else {
            value.text = v as? String
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

