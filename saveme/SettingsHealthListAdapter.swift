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

class SettingsHealthListAdapter: Adapter {

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

            if item.action == "insurance" {
                InsuranceDialog().show("insurancenum".localized) { _ in }
            }
            if item.action == "bloodtype" {
                BloodDialog().show("bloodtype".localized) { _ in }
            }
            if item.action == "allergies" {
                AllergyDialog().show("allergy".localized) { _ in }
            }
            if item.action == "medicines" {
                MedicineDialog().show("medicines".localized) { _ in }
            }
            if item.action == "medinfo" {
                MedDialog().show("medicaldetail".localized) { _ in }
            }
            if item.action == "doctors" {
                DoctorsDialog().show("doctors".localized) { _ in }
            }
            
            if item.action == "height" {
                var value = self.user?.safe(key: "height")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Please give your height".localized, message: "".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.height = alert?.textFields![0].text
                    self.reload()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            if item.action == "weight" {
                var value = self.user?.safe(key: "weight")
                if value == nil { value = "" }
                let alert = UIAlertController(title: "Please give your weight".localized, message: "".localized, preferredStyle: .alert)
                alert.addTextField { (textField) in textField.text = value as? String }
                alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
                    self.user?.weight = alert?.textFields![0].text
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
