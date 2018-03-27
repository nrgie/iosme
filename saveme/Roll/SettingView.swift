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
        
        
        if item.action == "insurance" {
            
            let v = DataStore.shared.userData?.safe(key: "taj")
            if value != nil {
                value.text = v as? String
            } else {
                value.text = " - "
            }
            
        }
        
        if item.action == "gender" {
            let gender = DataStore.shared.userData?.gender
            if gender != nil {
                if gender! == "1" {
                    value.text = "Male".localized
                } else {
                    value.text = "Female".localized
                }
            }
        }
        
        if item.action == "address" {
            /*
            public String home = "";
            public String zip = "";
            public String city = "";
            public String street = "";
            public String streetno = "";
            public String floordoor = "";
            */
            
            value.text = (DataStore.shared.userData?.zip)! + " " + (DataStore.shared.userData?.city)! + " " + (DataStore.shared.userData?.street)! + " " + (DataStore.shared.userData?.streetno)! + " " + (DataStore.shared.userData?.floordoor)!
        }
        
        if item.action == "spoken" {
            var text: String = ""
            let langs = DataStore.shared.userData?.langs!
            if langs != nil {
                for l in langs! {
                    if l.checked == true {
                        text += l.name + ", "
                    }
                }
            }
            value.text = text
        }
        
        if item.action == "parent" {
            value.text = "disabled"
        }
        
        if item.action == "bloodtype" {
            
            let blood = DataStore.shared.userData?.blood
            let bloodrh = DataStore.shared.userData?.bloodrh
            if blood != nil && bloodrh != nil {
                value.text = blood! + " " + bloodrh!
            }
            
        }
        
        if item.action == "height" {
            value.text = value.text! + " cm"
        }
        
        if item.action == "weight" {
            value.text = value.text! + " kg"
        }
        
        if item.action == "allergies" {
            var text: String = ""
            let alls = DataStore.shared.userData?.allergies!
            if alls != nil {
                for l in alls! {
                    if l.checked == true {
                        text += l.name + ", "
                    }
                }
            }
            value.text = text
        }
        
        if item.action == "medinfo" {
            var text: String = ""
            let langs = DataStore.shared.userData?.medinfo!
            if langs != nil {
                for l in langs! {
                    text += l.date + ":" + l.name + ", "
                }
            }
            value.text = text
        }
        
        if item.action == "medicines" {
            var text: String = ""
            let langs = DataStore.shared.userData?.med
            if langs != nil {
                for l in langs! {
                   text += l.name + ", "
                }
            }
            value.text = text
        }
        
        if item.action == "doctors" {
            var text: String = ""
            let langs = DataStore.shared.userData?.doctors!
            if langs != nil {
                for l in langs! {
                    text += l.name + ", "
                }
            }
            value.text = text
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

