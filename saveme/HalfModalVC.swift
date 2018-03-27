//
//  HalfModalVC.swift
//  saveme
//
//  Created by Tibi on 2018. 02. 28..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class ModalViewController: UIViewController, HalfModalPresentable {
    
    @IBAction func maximizeButtonTapped(sender: AnyObject) {
        maximizeToFullScreen()
    }
    
    @IBOutlet weak var tit: UILabel!
    
    @IBOutlet weak var listview: RollView!
    
    @IBAction func cancelmodalbtn(_ sender: Any) {
        
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = true
        }
        
        dismiss(animated: false, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tit.text = "".localized
        
        let adapter = SettingsHealthListAdapter()
        adapter.items = [
            Setting("", "Social insurance number".localized, "", "insurance"),
            Setting("", "Blood type".localized, "", "bloodtype"),
            Setting("", "Height".localized, "", "height"),
            Setting("", "Weight".localized, "", "weight"),
            Setting("", "Allergies".localized, "", "allergies"),
            Setting("", "Past or continues medial intervention".localized, "", "medinfo"),
            Setting("", "Your permanent medicines".localized, "", "medicines"),
            Setting("", "List of your doctors".localized, "", "doctors"),
        ]
        listview.adapter = adapter
        listview.reload()
        
    }
    
 }
