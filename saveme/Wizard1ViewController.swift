//
//  Wizard1ViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class Wizard1ViewController : UIViewController {

    @IBOutlet weak var listview: RollView!
    
    var spage: Bool = false
    public func forSettings() {
        spage = true
    }
    
    @IBAction func next(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard2", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard2") as! Wizard2ViewController
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
