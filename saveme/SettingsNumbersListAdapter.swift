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

class SettingsNumbersListAdapter: Adapter {

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
        
        let result: SettingView! = viewType(forPosition: position).init(frame: CGRect.zero) as? SettingView
        result.fill(with: items[position])
        result.isUserInteractionEnabled = true
        
        UITapGestureRecognizer(addToView: result) {
            
            if item.action == "emcountry" {
                CountryDialog(type:"emcountry").show("Select your current country") {_ in
                    let emc = DataStore.shared.userData?.emcountry

                    do {
                        if let path = Bundle.main.url(forResource: "nums", withExtension: "json") {
                            let data = try Data(contentsOf: path)
                            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                            var li = json!["data"] as? [[String: Any]]
                            for country in li! {
                                if let iso = country["iso"] as? String {
                                    if iso == emc {
                                        print(country)
                                        if country["M112"] as? Int == 1 {
                                            DataStore.shared.userData?.emnumber = "112"
                                            DataStore.shared.userData?.terrornumber = "112"
                                        } else {
                                            DataStore.shared.userData?.emnumber = country["C"] as? String
                                            DataStore.shared.userData?.terrornumber = country["C"] as? String
                                        }
                                        DataStore.shared.userData?.policenumber = country["P"] as? String
                                        DataStore.shared.userData?.ambulancenumber = country["A"] as? String
                                        DataStore.shared.userData?.firenumber = country["F"] as? String
                                    }
                                }
                            }
                            NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            if item.action == "emnumber" {
                var value = self.user?.safe(key: "emnumber")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Emergency number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.emnumber = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            if item.action == "policenumber" {
                var value = self.user?.safe(key: "policenumber")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Police number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.policenumber = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            if item.action == "firenumber" {
                var value = self.user?.safe(key: "firenumber")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Fire department number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.firenumber = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
            if item.action == "ambulancenumber" {
                var value = self.user?.safe(key: "ambulancenumber")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Amulance number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.ambulancenumber = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
            if item.action == "terrornumber" {
                var value = self.user?.safe(key: "terrornumber")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Anti-terror org. number".localized, message: "Please fill this input".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.terrornumber = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
        }
        return result
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        return SettingView.self
    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
}
