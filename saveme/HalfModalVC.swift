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
    
    @IBAction func cancelmodalbtn(_ sender: Any) {
        
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = true
        }
        
        dismiss(animated: false, completion: nil)
        
    }
    
 }
