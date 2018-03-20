//
//  Wizard1ViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class Wizard4ViewController : UIViewController {

    @IBOutlet weak var listview: RollView!
    
    var spage: Bool = false
    public func forSettings() {
        spage = true
    }
    
    @IBAction func prev(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard3", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard3") as! Wizard3ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    @IBAction func next(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard5", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard5") as! Wizard5ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    func reload() {
        listview.reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if spage == true {}
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Constants.Notifications.ReloadListView, object: nil)
        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        let adapter = SettingsNumbersListAdapter()
        adapter.items = [
            Setting("", "Selected country".localized, "", "country"),
            Setting("", "Emergency service phone number".localized, "", "emnuber"),
            Setting("", "Police phone number".localized, "", "policenumber"),
            Setting("", "Fire department phone".localized, "", "firenumber"),
            Setting("", "Ambulance phone number".localized, "", "ambulancenumber"),
            Setting("", "Anti-terrorist org number".localized, "", "terrornumber")
        ]
        
        listview.adapter = adapter
        listview.reload()
    }
    
    
}
