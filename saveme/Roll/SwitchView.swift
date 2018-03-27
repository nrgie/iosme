//
//  SettingView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class SwitchView: UIView {

    var litem: LangModel!
    var aitem: AllergyModel!
    
    var type: String = ""
    
    @IBOutlet private var label: UILabel!
    
    @IBOutlet weak var sw: UISwitch!
    @IBAction func swact(_ sender: Any) {
        if type == "a" {
            aitem.checked = sw.isOn
            NotificationCenter.default.post(name: Constants.Notifications.SaveAllergies, object: nil, userInfo: nil)
        }
        if type == "l" {
            litem.checked = sw.isOn
            NotificationCenter.default.post(name: Constants.Notifications.SaveSpoken, object: nil, userInfo: nil)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("SwitchView", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: LangModel) {
        self.type = "l"
        self.litem = item
        label.text = item.name!
        
        let langs = DataStore.shared.userData?.langs
        
        if langs != nil {
            for l in langs! {
                if l.name == litem.name {
                    if l.checked == true {
                        sw.setOn(true, animated: true);
                    } else {
                        sw.setOn(false, animated: true);
                    }
                }
            }
        } else {
            sw.setOn(false, animated: true);
        }
    }
    
    func fill(with item: AllergyModel) {
        self.type = "a"
        self.aitem = item
        label.text = item.name!
        let alls = DataStore.shared.userData?.allergies
        if alls != nil {
            for l in alls! {
                if l.name == item.name {
                    if l.checked == true {
                        sw.setOn(true, animated: true);
                    } else {
                        sw.setOn(false, animated: true);
                    }
                }
            }
        } else {
            sw.setOn(false, animated: true);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

