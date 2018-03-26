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
import DropDown

class BloodDialogView: UIView {

    let dropDown =  DropDown()
    let dropDownRh =  DropDown()

    @IBOutlet weak var dropbtn: UIButton!
    
    @IBOutlet weak var droprhbtn: UIButton!
    
    
    @IBAction func droprh(_ sender: Any) {
        dropDownRh.anchorView = droprhbtn
        dropDownRh.dataSource = ["Rh -", "Rh +"]
        dropDownRh.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0 {
                self.droprhbtn.setTitle("Rh -", for: .normal)
                DataStore.shared.userData?.bloodrh = "Rh -"
            }
            if index == 1 {
                self.droprhbtn.setTitle("Rh +", for: .normal)
                DataStore.shared.userData?.bloodrh = "Rh +"
            }
            NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
        }
        dropDownRh.show()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func drop(_ sender: Any) {
        dropDown.anchorView = dropbtn
        dropDown.dataSource = ["A", "B", "AB"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0 {
                self.dropbtn.setTitle("A", for: .normal)
                DataStore.shared.userData?.blood = "A"
            }
            if index == 1 {
                self.dropbtn.setTitle("B", for: .normal)
                DataStore.shared.userData?.blood = "B"
            }
            if index == 2 {
                self.dropbtn.setTitle("AB", for: .normal)
                DataStore.shared.userData?.blood = "AB"
            }
            NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
        }
        dropDown.show()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("BloodDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        
        let blood = DataStore.shared.userData?.blood
        let bloodrh = DataStore.shared.userData?.bloodrh
        
        if blood == "A"  {
            self.dropbtn.setTitle("A", for: .normal)
        }
        else if blood == "B"  {
            self.dropbtn.setTitle("B", for: .normal)
        }
        else if blood == "AB"  {
            self.dropbtn.setTitle("AB", for: .normal)
        }
        else {
            self.dropbtn.setTitle("A", for: .normal)
            DataStore.shared.userData?.blood = "A"
        }
        
        if bloodrh == "Rh -"  {
            self.droprhbtn.setTitle("Rh -", for: .normal)
        }
        else if bloodrh == "Rh +"  {
            self.droprhbtn.setTitle("Rh +", for: .normal)
        }
        else {
            self.droprhbtn.setTitle("Rh -", for: .normal)
            DataStore.shared.userData?.bloodrh = "Rh -"
        }
        
        addSubview(contentView)
    }
    
    func setup() {
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
