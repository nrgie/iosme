//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import Photos

class CountryDialogView: UIView, MRCountryPickerDelegate {
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        
        print(name)
        print(countryCode)
        
        if type == "national" {
            DataStore.shared.userData?.national = countryCode
        }
        
        if type == "emcountry" {
            DataStore.shared.userData?.emcountry = countryCode
            
        }
        
        self.reload()
        
        //self.countryName.text = name
        //self.countryCode.text = countryCode
        //self.phoneCode.text = phoneCode
        //self.countryFlag.image = flag
    }
    
    func getSelected() {
        countrypicker.getSelected()
    }
    
  
    var type: String = ""
    
    @IBOutlet weak var countrypicker: MRCountryPicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        
        countrypicker.countryPickerDelegate = self
        
        print(type)
        
        if type == "national" {
            let usernat = DataStore.shared.userData?.national
            if usernat != "" {
                countrypicker.setCountry(usernat!)
            }
            countrypicker.showPhoneNumbers = false
        }
        
        if type == "emcountry" {
            let usernat = DataStore.shared.userData?.emcountry
            if usernat != "" {
                countrypicker.setCountry(usernat!)
            }
            countrypicker.showPhoneNumbers = false
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("CountryDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
