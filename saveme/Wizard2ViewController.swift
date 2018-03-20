//
//  Wizard1ViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class Wizard2ViewController : UIViewController {

    var spage: Bool = false
    public func forSettings() {
        spage = true
    }
    
    
    @IBOutlet weak var listview: RollView!
    
    @IBAction func prev(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard1", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard1") as! Wizard1ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    @IBAction func next(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard3", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard3") as! Wizard3ViewController
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
       
        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
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
    
    
}
