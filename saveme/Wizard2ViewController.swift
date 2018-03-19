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
    
    
    @IBOutlet weak var snapvalue: UILabel!
    @IBOutlet weak var snapview: UIView!
    @IBOutlet weak var skypevalue: UILabel!
    @IBOutlet weak var skypeview: UIView!
    @IBOutlet weak var whatsvalue: UILabel!
    @IBOutlet weak var whatsview: UIView!
    @IBOutlet weak var vibervalue: UILabel!
    @IBOutlet weak var viberview: UIView!
    @IBOutlet weak var fbvalue: UILabel!
    @IBOutlet weak var fbview: UIView!
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
    
}
