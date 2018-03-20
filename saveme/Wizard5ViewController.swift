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

        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        let adapter = GuardListAdapter()
        adapter.items = [
            Setting("", "guard1".localized, "", "facebook")
        ]
    
        listview.adapter = adapter
        listview.reload()
    }
    
}
