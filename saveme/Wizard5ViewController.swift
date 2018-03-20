//
//  Wizard1ViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class Wizard5ViewController : UIViewController {

    @IBOutlet weak var listview: RollView!
    
    var spage: Bool = false
    public func forSettings() {
        spage = true
    }
    
    @IBAction func prev(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard4", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard4") as! Wizard4ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    @IBAction func next(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard6", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard6") as! Wizard6ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    func reload() {
        listview.reload()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if spage == true {
            // ide kellene amit elrejtünk. pl. back és save gombok. a lap alján a nevük és a funk hozzá.
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Constants.Notifications.ReloadListView, object: nil)
        
        //scroll.contentSize = CGSize();
        //scoll.contentSize.height = 540
        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        let adapter = SettingsListAdapter()
        adapter.items = [
            Setting("facebook_ikon", "Facebook account".localized, "", "facebook"),
            Setting("viber_ikon", "Viber".localized, "", "viber"),
            Setting("whatsapp_ikon", "Whatsapp".localized, "", "whatsapp"),
            Setting("skype_ikon", "Skype".localized, "", "skype"),
            Setting("snapchat_ikon", "Snapchat".localized, "", "snapchat")
        ]
        
        /*
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
         */
        listview.adapter = adapter
        listview.reload()
    }
    
}
