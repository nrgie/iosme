//
//  Wizard1ViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class Wizard3ViewController : UIViewController {

    var spage: Bool = false
    public func forSettings() {
        spage = true
    }
    
    @IBAction func prev(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard2", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard2") as! Wizard2ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    @IBAction func next(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard4", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard4") as! Wizard4ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
}
