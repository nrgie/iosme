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

class SettingsListAdapter: Adapter {

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
        
        if item.action == "name" {
            
            let result : SettingAvatarView! = viewType(forPosition: position).init(frame: CGRect.zero) as? SettingAvatarView
            result.fill(with: items[position])
            UITapGestureRecognizer(addToView: result) {
                FullNameDialog().show("Birth Day".localized, doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
                    (date) -> Void in
                    if let dt = date {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        self.user?.bday = formatter.string(from: dt)
                        self.reload()
                    }
                }
            }
            result.isUserInteractionEnabled = true
            return result
            
        } else {
            
            let result: SettingView! = viewType(forPosition: position).init(frame: CGRect.zero) as? SettingView
            result.fill(with: items[position])
            result.isUserInteractionEnabled = true
            
            UITapGestureRecognizer(addToView: result) {
                if item.action == "phone" {
                    var value = self.user?.safe(key: "phone")
                    if value == nil { value = "" }
                    let alert = UIAlertController(title: "Fill your phone number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                    alert.addTextField { (textField) in textField.text = value as? String }
                    alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                        self.user?.phone = alert?.textFields![0].text
                        self.reload()
                    }))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                if item.action == "email" {
                    var value = self.user?.safe(key: "email")
                    if value == nil { value = "" }
                    let alert = UIAlertController(title: "Fill your email address".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                    alert.addTextField { (textField) in textField.text = value as? String }
                    alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                        self.user?.email = alert?.textFields![0].text
                        self.reload()
                    }))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                if item.action == "password" {
                    var value = self.user?.safe(key: "password")
                    if value == nil { value = "" }
                    let alert = UIAlertController(title: "Fill your password".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                    alert.addTextField { (textField) in textField.text = value as? String }
                    alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                        self.user?.password = alert?.textFields![0].text
                        self.reload()
                    }))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                
                if item.action == "bday" {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    var date = dateFormatter.date(from: (self.user?.bday)!)
                    if date == nil {
                        date = dateFormatter.date(from: "1980-01-01")
                    }
                    DatePickerDialog().show("Birth Day".localized, doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: date!, datePickerMode: .date) {
                        (date) -> Void in
                        if let dt = date {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            self.user?.bday = formatter.string(from: dt)
                            self.reload()
                        }
                    }
                }
                
            }
            
            return result
        }
        
        
        

    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        
        let item : Setting = items[position]
        if item.action == "name" {
            return SettingAvatarView.self
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

