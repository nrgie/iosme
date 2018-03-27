//
//  SettingView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class AllergySwitchView: UIView {

    
    @IBOutlet private var label: UILabel!
    
    
    @IBOutlet weak var sw: UISwitch!
    @IBAction func swact(_ sender: Any) {
        self.checked = sw.isOn
    }
    
    var checked: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("AllergySwitchView", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: AllergyModel) {
        label.text = item.name!
        // fill with userdata
        // check in loop
        
        sw.isOn = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

