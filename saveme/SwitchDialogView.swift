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

class SwitchDialogView: UIView, OpalImagePickerControllerDelegate {
    
    var imagepicker = UIImagePickerController()
    
    var onTitle: String!
    var offTitle: String!
    var state: Bool = false
    var type: String!
    
    @IBOutlet weak var offLabel: UILabel!
    @IBOutlet weak var onLabel: UILabel!
    
    @IBOutlet weak var sw: UISwitch!
    
    @IBAction func switched(_ sender: Any) {
        if sw.isOn == true {
            
            if type == "learn" {
                AppDelegate.shared.learnmode = true
            }
            
            if type == "track" {
                DataStore.shared.userData?.cantrack = true
            }
            
            if type == "gender" { // lány ha true
                DataStore.shared.userData?.gender = "1"
            }
            
        } else {
            
            if type == "learn" {
                AppDelegate.shared.learnmode = false
            }
            
            if type == "track" {
                DataStore.shared.userData?.cantrack = false
            }
            
            if type == "gender" {
                DataStore.shared.userData?.gender = "0"
            }
            
        }
    }

    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        offLabel.text = offTitle
        onLabel.text = onTitle
        sw.isOn = state
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("SwitchDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
