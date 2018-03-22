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
            
            let result : SettingIconView! = viewType(forPosition: position).init(frame: CGRect.zero) as? SettingIconView
            result.fill(with: items[position])
            UITapGestureRecognizer(addToView: result) {
                
                if item.action == "w1" {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard1", bundle: nil)
                    let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard1") as! Wizard1ViewController
                    c.spage = true
                    UIApplication.shared.delegate?.window??.rootViewController = c
                }
                if item.action == "w2" {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard2", bundle: nil)
                    let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard2") as! Wizard2ViewController
                    c.spage = true
                    UIApplication.shared.delegate?.window??.rootViewController = c
                }
                if item.action == "w3" {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard3", bundle: nil)
                    let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard3") as! Wizard3ViewController
                    c.spage = true
                    UIApplication.shared.delegate?.window??.rootViewController = c
                }
                if item.action == "w4" {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard4", bundle: nil)
                    let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard4") as! Wizard4ViewController
                    c.spage = true
                    UIApplication.shared.delegate?.window??.rootViewController = c
                }
                if item.action == "w5" {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard5", bundle: nil)
                    let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard5") as! Wizard5ViewController
                    c.spage = true
                    UIApplication.shared.delegate?.window??.rootViewController = c
                }
                if item.action == "w6" {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard6", bundle: nil)
                    let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard6") as! Wizard6ViewController
                    c.spage = true
                    UIApplication.shared.delegate?.window??.rootViewController = c
                }

                if item.action == "exit" {
                    DataStore.shared.clearData()
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Splash", bundle: nil)
                    let baseController = mainStoryboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
                    UIApplication.shared.delegate?.window??.rootViewController = baseController
                }
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
            return SettingIconView.self
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

