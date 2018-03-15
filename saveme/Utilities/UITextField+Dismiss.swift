//
//  UITextField+Dismiss.swift
//
//  Created by CodeYard MacMini on 22/11/16.
//  Copyright © 2016 CodeYard. All rights reserved.
//

import UIKit

@objc class InputDelegator: NSObject, UITextFieldDelegate, UITextViewDelegate{
    
    static let sharedInstance = InputDelegator()
    static let showKeyboardNotification = NSNotification.Name(rawValue: "showKeyboardEvent")
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: InputDelegator.showKeyboardNotification, object: textField)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}

extension UITextField {
    
    func registerForDismiss() {
        self.delegate = InputDelegator.sharedInstance
        self.returnKeyType = UIReturnKeyType.done
    }
    
}

extension UITextView {
    
    func registerForDismiss() {
        self.delegate = InputDelegator.sharedInstance
    }
    
}
