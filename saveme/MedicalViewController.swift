//
//  MedicalViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 23..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class MedicalViewController: UIViewController {
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
        
    }
    
    // ide kell feltölteni majd user infóval
    
}
