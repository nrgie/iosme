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
import CountryPicker

class CountryDialogView: UIView, CountryPickerDelegate {
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        if type == "national" {
            DataStore.shared.userData?.national = countryCode
        }
    }
    
  
    var type: String = ""
    
    @IBOutlet weak var countrypicker: CountryPicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        
        countrypicker.delegate = self as! UIPickerViewDelegate
        
        if type == "national" {
            var usernat = DataStore.shared.userData?.national
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
