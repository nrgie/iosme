//
//  FullNameVC.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 17..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class FullNameVC : UIViewController {

    @IBAction func savebtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard1", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard1") as! Wizard1ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard1", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard1") as! Wizard1ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    override func viewDidLoad() {
        
    }
    
}
