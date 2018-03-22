//
//  SettingsListAdapter.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class QuickSettingsListAdapter: Adapter {

    var items: [Setting]!
    let user = DataStore.shared.userData
    
    var count: Int {
        return items.count
    }
    
    func item(forPosition position: Int) -> Any {
        return items[position]
    }
    
    func view(forPosition position: Int, convertView: UIView?) -> UIView {
        
        let item : Setting = items[position]
        if item.action == "separator" {
            let result : ListSeparator! = viewType(forPosition: position).init(frame: CGRect.zero) as? ListSeparator
            result.fill(with: items[position])
            result.isUserInteractionEnabled = true
            return result
        } else {
            
            let result : SettingView! = viewType(forPosition: position).init(frame: CGRect.zero) as? SettingView
            result.fill(with: items[position])
            UITapGestureRecognizer(addToView: result) {
                /*
                FullNameDialog().show("Full Name".localized, doneButtonTitle: "Save".localized, cancelButtonTitle: "Cancel".localized, datePickerMode: .date) {
                    (date) -> Void in
                    if let dt = date {
                        //let formatter = DateFormatter()
                        //formatter.dateFormat = "yyyy-MM-dd"
                        //self.user?.bday = formatter.string(from: dt)
                        self.reload()
                    }
                }*/
                
            }
            
            result.isUserInteractionEnabled = true
            return result
        }
        
        
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        
        let item : Setting = items[position]
        if item.action == "separator" {
            return ListSeparator.self
        } else {
            return SettingView.self
        }

    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
}



/*
 showInputDialog(title: "Add number",
 subtitle: "Please enter the new number below.",
 actionTitle: "Add",
 cancelTitle: "Cancel",
 inputPlaceholder: "New number",
 inputKeyboardType: .numberPad)
 { (input:String?) in
 print("The new number is \(input ?? "")")
 }
 */

