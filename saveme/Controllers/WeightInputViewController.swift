//
//  WeightInputViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 10..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class WeightInputViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var keyboardAccessoryView: UIToolbar!
    var program: Program?
    var activetextField: UITextField?
    
    override var inputAccessoryView: UIView {
        return keyboardAccessoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            self.bottomConstraint?.constant = self.view.frame.height-(endFrame?.origin.y)!
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
            
        }
    }
    
    @IBAction func dismiss(_ sender: UIGestureRecognizer) {
        self.close()
    }
    
    func close() {
        self.activetextField?.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: UIBarButtonItem) {
        self.activetextField?.resignFirstResponder()
    }
    
    @IBAction func saveWeight(_ sender: UIButton) {
        if activetextField?.text == nil || activetextField?.text == "" {
            MessageUtils.show(message: "Error".localized, on: self)
            return
        }
        RestClient.sendWeight(weight: (activetextField?.text)!, day: self.program!.currentDay, accessToken: DataStore.shared.getAccessToken()!) { (success: Bool?) in
            self.close()
            if success == true {
                RestClient.getPrograms(accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (err: String?, programs: [Program]?) in
                    if programs != nil {
                        DataStore.shared.programs = programs
                        NotificationCenter.default.post(name: Constants.Notifications.ProgramUpdatedNotification, object: nil)
                        
                    }
                })
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension WeightInputViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activetextField = textField
    }
}

extension WeightInputViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.containerView))!{
            return false
        }
        return true
    }
}

