//
//  SigninViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper

class SigninPageViewController : UIViewController {
    
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var emailF: UITextField!
    @IBOutlet weak var passF: UITextField!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.emailF.registerForDismiss()
        self.passF.registerForDismiss()
        let emailValid: Observable<Bool> = self.emailF.rx.text.map { text in
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return ((text?.characters.count)! > 0 && NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: text))
            }.shareReplay(1)
        let passwordValid: Observable<Bool> = self.passF.rx.text.map { text in
            return (text?.characters.count)! > 0
            }.shareReplay(1)
        let everythingValid: Observable<Bool>
            = Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
        everythingValid.bindTo(self.loginButton.rx.isEnabled).addDisposableTo(self.disposeBag)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showMain), name: Constants.Notifications.UserLoggedInNotification, object: nil)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    
    @IBAction func LoginUser(_ sender: Any) {
        self.view.endEditing(true)
        
        
        let url = URL(string: "http://api.saveme-app.com/login.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "email="+(self.emailF.text ?? "") + "&pass="+(self.passF.text  ?? "")
        
        var loggedin = false
        
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            
            if(responseString == "none") {
                // invalid login
                MessageUtils.show(message: "Invalid User Login".localized, with: "Error".localized, on: self)
                
            } else {
                
                //let json : AnyObject! = JSONSerialization.JSONObjectWithData(responseString, options: JSONSerialization.ReadingOptions.MutableContainers, error: error)

                let user = UserData(JSONString: responseString!)
                DataStore.shared.userData = user
                
                
                //DataStore.shared.userData = resuserDataResponse?.userData.first
//                let userarr: Array<UserData> = Mapper<UserData>().mapArray(JSONString: responseString!)

                
                
                DataStore.shared.setAccessToken(token: responseString!)
                NotificationCenter.default.post(name: Constants.Notifications.UserLoggedInNotification, object: nil, userInfo: nil)
                
            }
            
            print("postString = \(postString)")
            
        }
        task.resume()
        
    }
    
    func showMain(notification: NSNotification) {
        DispatchQueue.main.async(){
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
            let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
            UIApplication.shared.delegate?.window??.rootViewController = baseController
        }
    }
    
    @IBAction func showInfo(_ sender: Any) {
        NotificationCenter.default.post(name: Constants.Notifications.ShowInfoNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
