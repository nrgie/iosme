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
    
}
