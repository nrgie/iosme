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

    
    @IBAction func prev(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard4", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard4") as! Wizard4ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    @IBAction func next(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard6", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard6") as! Wizard4ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    

    
}
