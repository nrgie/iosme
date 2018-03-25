//
//  Wizard1ViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class WizardContent : UIViewController {

    @IBOutlet weak var listview: RollView!
    @IBOutlet weak var uititle: UILabel!
    
    var pagetype: Int = 1
    var label: String = "SETTINGS"
    
    public func forSettings(type:Int) {
        pagetype = type
    }
    
    @IBAction func next(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "QuickSettings", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "QuickSettings") as! QuickSettingsViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    func reload() {
        listview.reload()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Constants.Notifications.ReloadListView, object: nil)
        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        uititle.text = label
        
        if pagetype == 1 {
            let adapter = SettingsListAdapter()
            adapter.items = [
                Setting("", "Fullname", "", "name"),
                Setting("", "Phone number", "", "phone"),
                Setting("", "Email address", "", "email"),
                Setting("", "Password", "", "password"),
                Setting("", "Birth Date", "", "bday"),
                Setting("", "Gender", "", "gender"),
                Setting("", "Citizenship", "", "national"),
                Setting("", "Spoken language", "", "spoken"),
                Setting("", "Address", "", "address"),
                Setting("", "Parent Control", "", "parent")
            ]
            listview.adapter = adapter
            listview.reload()
        }
        
        if pagetype == 2 {
            let adapter = SettingsContactListAdapter()
            adapter.items = [
                Setting("facebook_ikon", "Facebook account".localized, "", "facebook"),
                Setting("viber_ikon", "Viber".localized, "", "viber"),
                Setting("whatsapp_ikon", "Whatsapp".localized, "", "whatsapp"),
                Setting("skype_ikon", "Skype".localized, "", "skype"),
                Setting("snapchat_ikon", "Snapchat".localized, "", "snapchat")
            ]
            listview.adapter = adapter
            listview.reload()
        }
        
        if pagetype == 3 {
            let adapter = SettingsHealthListAdapter()
            adapter.items = [
                Setting("", "Social insurance number".localized, "", "insurance"),
                Setting("", "Blood type".localized, "", "bloodtype"),
                Setting("", "Height".localized, "", "height"),
                Setting("", "Weight".localized, "", "weight"),
                Setting("", "Allergies".localized, "", "allergies"),
                Setting("", "Past or continues medial intervention".localized, "", "medinfo"),
                Setting("", "Your permanent medicines".localized, "", "medicines"),
                Setting("", "List of your doctors".localized, "", "doctors"),
            ]
            listview.adapter = adapter
            listview.reload()
        }
        
        if pagetype == 4 {
            let adapter = SettingsNumbersListAdapter()
            adapter.items = [
                Setting("", "Selected country".localized, "", "country"),
                Setting("", "Emergency service phone number".localized, "", "emnumber"),
                Setting("", "Police phone number".localized, "", "policenumber"),
                Setting("", "Fire department phone".localized, "", "firenumber"),
                Setting("", "Ambulance phone number".localized, "", "ambulancenumber"),
                Setting("", "Anti-terrorist org number".localized, "", "terrornumber")
            ]
            listview.adapter = adapter
            listview.reload()
        }
        
        if pagetype == 5 {
            let adapter = GuardListAdapter()
            adapter.items = DataStore.shared.userData?.guards
            listview.adapter = adapter
            listview.reload()
        }
        
        if pagetype == 6 {
            let adapter = ProductsAdapter()
            adapter.products = [
                "SOS alert",
                "Calling Emergency number in the background",
                "SMS notification to Emergency number",
                "Police Emergency Alert",
                "Calling Police Emergency number in the background",
                "SMS notification to Police Emergency number",
                "Fire Department Emergency Alert",
                "Calling Fire Department Emergency number in the background",
                "SMS notification to Fire Department Emergency number",
                "Ambulance Emergency Alert",
                "Calling Ambulance Emergency number in the background",
                "SMS notification to Ambulance Emergency number",
                "Terrorist Attack Emergency Alert",
                "Calling Emergency Number in the background",
                "SMS to Emergency Number",
                "Notify your Guardian Angels by phone call in the background",
                "Notify your Guardian Angels by sms in the background",
                "Notify your Guardian Angels by e-mail",
            ]
            listview.adapter = adapter
            listview.reload()
        }
        

    }
}
