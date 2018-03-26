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
            if item.value == "" {
                let result : SettingIconViewOneLine! = viewType(forPosition: position).init(frame: CGRect.zero) as? SettingIconViewOneLine
                
                result.fill(with: items[position])
                
                UITapGestureRecognizer(addToView: result) {
                    
                    if item.action == "w1" {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizardcontent", bundle: nil)
                        let c = mainStoryboard.instantiateViewController(withIdentifier: "wizardcontent") as! WizardContent
                        c.pagetype = 1
                        c.label = "General Settings"
                        UIApplication.shared.delegate?.window??.rootViewController = c
                    }
                    if item.action == "w2" {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizardcontent", bundle: nil)
                        let c = mainStoryboard.instantiateViewController(withIdentifier: "wizardcontent") as! WizardContent
                        c.pagetype = 2
                        c.label = "Contact Settings"
                        UIApplication.shared.delegate?.window??.rootViewController = c
                    }
                    if item.action == "w3" {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizardcontent", bundle: nil)
                        let c = mainStoryboard.instantiateViewController(withIdentifier: "wizardcontent") as! WizardContent
                        c.pagetype = 3
                        c.label = "Medical Settings"
                        UIApplication.shared.delegate?.window??.rootViewController = c
                    }
                    if item.action == "w4" {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizardcontent", bundle: nil)
                        let c = mainStoryboard.instantiateViewController(withIdentifier: "wizardcontent") as! WizardContent
                        c.pagetype = 4
                        c.label = "Phone Numbers"
                        UIApplication.shared.delegate?.window??.rootViewController = c
                    }
                    if item.action == "w5" {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizardcontent", bundle: nil)
                        let c = mainStoryboard.instantiateViewController(withIdentifier: "wizardcontent") as! WizardContent
                        c.pagetype = 5
                        c.label = "Guardians Settings"
                        UIApplication.shared.delegate?.window??.rootViewController = c
                    }
                    if item.action == "w6" {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizardcontent", bundle: nil)
                        let c = mainStoryboard.instantiateViewController(withIdentifier: "wizardcontent") as! WizardContent
                        c.pagetype = 6
                        c.label = "Alert Settings"
                        UIApplication.shared.delegate?.window??.rootViewController = c
                    }
                    
                    if item.action == "exit" {
                        DataStore.shared.clearData()
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Splash", bundle: nil)
                        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
                        UIApplication.shared.delegate?.window??.rootViewController = baseController
                    }

                    if item.action == "helppage" {
                        HelpDialog(showCancelButton:false).show("PLEASE SELECT HELP") {_ in }
                    }
                    if item.action == "langpage" {
                        LangDialog(showCancelButton:false).show("APPLICATION LANGUAGE".localized) {_ in }
                    }
                    
                    if item.action == "termspage" {
                        // open url
                        guard let url = URL(string: "http://saveme-app.com/terms.html") else {
                            return
                        }
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                    if item.action == "invitepage" {
                        // firebase ?
                        // átmenetileg off. kell a google login.
                    }
                    if item.action == "playsound" {
                        PlaySoundDialog(showCancelButton:false).show("PLAY YOUR DEMO EMERGENCY MESSAGE") {_ in }
                    }
                    
                }
                
                result.isUserInteractionEnabled = true
                return result
                
            } else {
                
                let result : SettingIconView! = viewType(forPosition: position).init(frame: CGRect.zero) as? SettingIconView
                result.fill(with: items[position])
                
                UITapGestureRecognizer(addToView: result) {
                    
                    // ide jönnek a felsők, subtitles blokkok 3 db.
                    
                    if item.action == "w4" {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizardcontent", bundle: nil)
                        let c = mainStoryboard.instantiateViewController(withIdentifier: "wizardcontent") as! WizardContent
                        c.pagetype = 4
                        c.label = "Emergency Numbers"
                        UIApplication.shared.delegate?.window??.rootViewController = c
                    }
                    
                    if item.action == "learn" {
                        SwitchDialog(showCancelButton:false).show("Learning Mode".localized, doneButtonTitle: "Ok".localized, cancelButtonTitle: "Cancel".localized, onTitle: "On", offTitle:"Off", switchType: "learn", switchState: AppDelegate.shared.learnmode)
                            {_ in self.reload() }
                    }
                    
                    if item.action == "tracking" {
                        SwitchDialog(showCancelButton:false).show("Can others watch your location ?".localized, doneButtonTitle: "Ok".localized, cancelButtonTitle: "Cancel".localized, onTitle: "Enabled", offTitle:"Disabled", switchType: "track", switchState: (DataStore.shared.userData?.cantrack)!) {_ in self.reload() }
                    }
                    
                }
                
                result.isUserInteractionEnabled = true
                return result
                
            }
                
            
        }
        
        
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        
        let item : Setting = items[position]
        if item.action == "separator" {
            return ListSeparator.self
        } else {
            if item.value == "" {
                return SettingIconViewOneLine.self
            } else {
                return SettingIconView.self
            }
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

