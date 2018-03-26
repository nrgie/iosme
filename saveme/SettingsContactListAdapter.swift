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

class SettingsContactListAdapter: Adapter {

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
        
        let result: SettingIconView! = viewType(forPosition: position).init(frame: CGRect.zero) as? SettingIconView
        result.fill(with: items[position], with:false)
        result.isUserInteractionEnabled = true
            
        UITapGestureRecognizer(addToView: result) {
            if item.action == "facebook" {
                var value = self.user?.safe(key: "facebook")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Fill your phone number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.facebook = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            if item.action == "viber" {
                var value = self.user?.safe(key: "viber")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Fill your phone number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.viber = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            if item.action == "whatsapp" {
                var value = self.user?.safe(key: "whatsapp")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Fill your phone number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.whatsapp = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            if item.action == "skype" {
                var value = self.user?.safe(key: "skype")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Fill your phone number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.skype = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            if item.action == "snapchat" {
                var value = self.user?.safe(key: "snapchat")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Fill your phone number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.snapchat = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        return result
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        return SettingIconView.self
    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
}
