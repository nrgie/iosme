//
//  UserDataEditorEmbedViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit
import M13Checkbox

protocol RegistrationEmbedProtocol {
    func scrollViewDidScroll(newHeight: Float)
}

class UserDataEditorEmbedViewController: UITableViewController {
    
    @IBOutlet var staticSectionHeaderView: UIView!
    @IBOutlet var keyboardAccessoryView: UIToolbar!
    
    override var inputAccessoryView: UIView {
        return keyboardAccessoryView
    }
    
    @IBOutlet var prevAccessoryButton: UIBarButtonItem!
    @IBOutlet var nextAccessoryButton: UIBarButtonItem!
    @IBOutlet var doneAccessoryButton: UIBarButtonItem!
    
    
    @IBOutlet var lastNameTextField: FATextField!
    @IBOutlet var firstNameTextField: FATextField!
    @IBOutlet var userNameTextField: FATextField!
    @IBOutlet var emailTextField: FATextField!
    @IBOutlet var birthYearTextField: FATextField!
    
    @IBOutlet var maleCheckBox: M13Checkbox!
    @IBOutlet var femaleCheckBox: M13Checkbox!
    
    @IBOutlet var cityTextField: FATextField!
    @IBOutlet var passwordTextField: FATextField!
    @IBOutlet var passwordAgainTextField: FATextField!
    
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var logoutButton: UIButton!
    
    var parentVC: RegistrationViewController?
    
    var responders: Array<FATextField> = Array<FATextField>()
    
    var userData: UserData? {
        didSet {
            self.initFields()
        }
    }
    
    var activetextField: FATextField? {
        didSet {
            if activetextField == responders.first {
                prevAccessoryButton?.isEnabled = false
            } else {
                prevAccessoryButton?.isEnabled = true
            }
            
            if activetextField == responders.last {
                nextAccessoryButton?.isEnabled = false
            } else {
                nextAccessoryButton?.isEnabled = true
            }
        }
    }
    var gender: String {
        if self.maleCheckBox.checkState == .checked {
            return "male"
        } else if self.femaleCheckBox.checkState == .checked {
            return "female"
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DataStore.shared.userData != nil {
            self.userData = DataStore.shared.userData
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        maleCheckBox.setMarkType(markType: .radio, animated: true)
        maleCheckBox.animationDuration = 0.0
        
        femaleCheckBox.setMarkType(markType: .radio, animated: true)
        femaleCheckBox.animationDuration = 0.0
        self.updateBackgroundHeight(self.tableView, isViewDidLoad: true)
        
        responders.append(lastNameTextField)
        responders.append(firstNameTextField)
        responders.append(userNameTextField)
        responders.append(emailTextField)
        responders.append(birthYearTextField)
        responders.append(cityTextField)
        responders.append(passwordTextField)
        responders.append(passwordAgainTextField)
        
        self.initFields()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initFields() {
        if userData == nil { return }
        /*
        self.lastNameTextField?.text = userData!.lastName
        self.firstNameTextField?.text = userData!.firstName
        self.emailTextField?.text = userData!.email
        self.userNameTextField?.text = userData!.userName
        self.birthYearTextField?.text = userData!.yearOfBirth
        self.cityTextField?.text = userData!.settlement
        
        if userData!.gender != "", maleCheckBox != nil, femaleCheckBox != nil {
            if userData!.gender == "male" {
                self.checkStateChanged(maleCheckBox)
                self.maleCheckBox.checkState = .checked
            } else if userData!.gender == "female" {
                self.checkStateChanged(femaleCheckBox)
                self.femaleCheckBox.checkState = .checked
            }
        }
 */
    }
    
    
    @IBAction func checkStateChanged(_ radioButton: M13Checkbox) {
        if radioButton == maleCheckBox {
            if maleCheckBox.checkState == .unchecked {
                femaleCheckBox.setCheckState(.unchecked, animated: true)
                femaleCheckBox.isEnabled = true
                maleCheckBox.isEnabled = false
            }
        } else if radioButton == femaleCheckBox {
            if femaleCheckBox.checkState == .unchecked {
                maleCheckBox.setCheckState(.unchecked, animated: true)
                maleCheckBox.isEnabled = true
                femaleCheckBox.isEnabled = false
            }
        }
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        guard (self.lastNameTextField.text?.characters.count)! >= 3 else {
            error("Registrate.Error.LastName".localized)
            return
        }
        guard (self.firstNameTextField.text?.characters.count)! >= 3 else {
            error("Registrate.Error.FirstName".localized)
            return
        }
        guard (self.userNameTextField.text?.characters.count)! >= 3 else {
            error("Registrate.Error.UserName".localized)
            return
        }
        guard (self.emailTextField.text?.characters.count)! >= 3 else {
            error("Registrate.Error.Email".localized)
            return
        }
        guard (self.birthYearTextField.text?.characters.count)! == 4 else {
            error("Registrate.Error.BirthDay".localized)
            return
        }
        guard (self.cityTextField.text?.characters.count)! >= 3 else {
            error("Registrate.Error.City".localized)
            return
        }
        guard (self.passwordTextField.text?.characters.count)! >= 8 else {
            error("Registrate.Error.Password".localized)
            return
        }
        guard (self.passwordAgainTextField.text?.characters.count)! >= 8 else {
            error("Registrate.Error.PasswordConfirm".localized)
            return
        }
        guard self.passwordTextField.text == self.passwordAgainTextField.text else {
            error("Registrate.Error.PasswordNotMatched".localized)
            return
        }
        guard (self.gender.characters.count) != 0 else {
            error("Registrate.Error.Gender".localized)
            return
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        guard NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self.emailTextField.text) == true else {
            error("Registrate.Error.InvalidEmail".localized)
            return
        }
        
        //sender.isEnabled = false
        RestClient.registrate(user_params: ["first_name":self.firstNameTextField.text ?? "",
                                            "last_name":self.lastNameTextField.text ?? "",
                                            "username":self.userNameTextField.text ?? "",
                                            "email":self.emailTextField.text ?? "",
                                            "year_of_birth":self.birthYearTextField.text ?? "",
                                            "settlement":self.cityTextField.text ?? "",
                                            "password":self.passwordTextField.text ?? "",
                                            "password_confirmation":self.passwordAgainTextField.text ?? "",
                                            "gender":self.gender]) {[weak self] (result: String?) in
                                                
                                                let parent = self?.parent as! RegistrationViewController
                                                let parentNavController = parent.parent as! CustomNavigationController
                                                print(parent)
                                                print(parentNavController)
                                                
                                                
                                                if result != nil {
                                                    RestClient.performOAuthCall(params: ["client_id": Constants.EndPoints.clientId,"grant_type": "password", "client_secret": Constants.EndPoints.clientSecret, "email": self?.emailTextField.text ?? "", "password": self?.passwordTextField.text ?? "" ]) { (error: String?, result: OAuthResponse?) in
                                                        if (error == nil) {
                                                            DataStore.shared.setAccessToken(token: result!.accessToken)
                                                            RestClient.getUser(accessToken: result!.accessToken, complitionBlock: { (error: String?, userResponse: UserResponse?) in
                                                                if error == nil && userResponse!.userId != nil {
                                                                    RestClient.getUserData(userId: userResponse!.userId, accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (error: String?, userDataResponse: UserDataResponse?) in
                                                                        if error == nil {
                                                                            DataStore.shared.userData = userDataResponse?.userData.first
                                                                            DataStore.shared.subscriptions = userDataResponse?.userSubscriptions
                                                                            NotificationCenter.default.post(name: Constants.Notifications.UserRegistrationNotification, object: nil, userInfo: nil)

                                                                            
                                                                            let rootController: DecideViewController? = self?.storyboard?.instantiateViewController(withIdentifier: "DecideViewController") as? DecideViewController
                                                                            parentNavController.setViewControllers([rootController!], animated: true)
                                                                            
                                                                            /*
                                                                            let rootController: QuestionnarieViewController? = self?.storyboard?.instantiateViewController(withIdentifier: "QuestionnarieViewController") as? QuestionnarieViewController
                                                                            parentNavController.setViewControllers([rootController!], animated: true)
                                                                             */
                                                                            
                                                                        } else {
                                                                            MessageUtils.show(message: error!, with: "Error".localized, on: self!)
                                                                        }
                                                                    })
                                                                    DataStore.shared.setUserId(userId: userResponse!.userId)
                                                                } else {
                                                                    MessageUtils.show(message: error!, with: "Error".localized, on: self!)
                                                                }
                                                            })
                                                        } else {
                                                            MessageUtils.show(message: error!, with: "Error".localized, on: self!)
                                                        }
                                                    }
                                                    
                                                    
                                                }
                                                //sender.isEnabled = true
        }
    }
    
    func error(_ message: String) {
        MessageUtils.show(message: message, with: "Error".localized, on: self)
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        var data = Dictionary<String, String>()
        if (self.lastNameTextField.text?.characters.count)! >= 3 {
            data["last_name"] = self.lastNameTextField.text
        } else {
            error("Profile.Error.LastName".localized)
            return
        }
        if (self.firstNameTextField.text?.characters.count)! >= 3 {
            data["first_name"] = self.firstNameTextField.text
        } else {
            error("Profile.Error.FirstName".localized)
            return
        }
        if (self.userNameTextField.text?.characters.count)! >= 3 {
            data["username"] = self.userNameTextField.text
        } else {
            error("Profile.Error.UserName".localized)
            return
        }
        if (self.emailTextField.text?.characters.count)! >= 3 {
            data["email"] = self.emailTextField.text
        } else {
            error("Profile.Error.Email".localized)
            return
        }
        if (self.birthYearTextField.text?.characters.count)! == 4 {
            data["year_of_birth"] = self.birthYearTextField.text
        } else {
            error("Profile.Error.BirthDay".localized)
            return
        }
        if (self.cityTextField.text?.characters.count)! >= 3 {
            data["settlement"] = self.cityTextField.text
        } else {
            error("Profile.Error.City".localized)
            return
        }
        if ((self.passwordTextField.text == nil || self.passwordTextField.text == "") && self.passwordTextField.text == self.passwordAgainTextField.text){
            // Don't need to validate
        } else {
            if (self.passwordTextField.text?.characters.count)! >= 8 {
                data["password"] = self.passwordTextField.text
                
                if (self.passwordAgainTextField.text?.characters.count)! >= 8 {
                    data["password_confirmation"] = self.passwordAgainTextField.text
                } else {
                    error("Profile.Error.PasswordConfirm".localized)
                }
            } else {
                error("Profile.Error.Password".localized)
            }
        }
        
        
        if (self.gender.characters.count) != 0 {
            data["gender"] = self.gender
        }
        
        guard self.passwordTextField.text == self.passwordAgainTextField.text else {
            error("Profile.Error.PasswordNotMatched")
            return
        }
        
        data["modify_date"] = String(Date().timeIntervalSince1970)
        /*
        RestClient.updateUser(userId: (self.userData?.id)!, userParams: data, access_token: DataStore.shared.getAccessToken()!) {[weak self] (result: String?, resp: OAuthResponse?) in
                if resp != nil {
                    MessageUtils.show(message: "Profile.Update.Success".localized, with: "Success".localized, on: self!)
                } else {
                    MessageUtils.show(message: "Error.Unknown".localized, with: "Error".localized, on: self!)
                }
                //sender.isEnabled = true
        }
 */
        
    }
    
    @IBAction func logout(_ sender: UIButton) {
        DataStore.shared.clearData()
        NotificationCenter.default.post(name: Constants.Notifications.UserLoggedOutNotification, object: nil, userInfo: nil)
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateBackgroundHeight(scrollView, isViewDidLoad: false)
    }
    
    
    func updateBackgroundHeight(_ scrollView: UIScrollView, isViewDidLoad: Bool = false) {
        let parent = parentVC
        
        if (isViewDidLoad == true) {
            parent?.scrollViewDidScroll(newHeight: Float(self.tableView.frame.height - (self.tableView.tableHeaderView?.frame.height)! - UIApplication.shared.statusBarFrame.height-44.0))
        } else if ((scrollView.contentOffset.y - (self.tableView.tableHeaderView?.frame.height)!) <= 0.0) {
            parent?.scrollViewDidScroll(newHeight: Float(self.tableView.frame.height - (self.tableView.tableHeaderView?.frame.height)!+scrollView.contentOffset.y))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return self.staticSectionHeaderView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 44.0
        }
        return 0.0
    }
    
}

// MARK: - Input accessory handlers
extension UserDataEditorEmbedViewController {
    
    @IBAction func jumpPreviousField(_ sender: UIBarButtonItem) {
        let currentIndex = self.responders.index(of: self.activetextField!)!
        let prevIndex = self.responders.index(before: currentIndex)
        if self.responders.atIndex(index: prevIndex) != nil {
            self.responders[prevIndex].becomeFirstResponder()
        }
    }
    
    @IBAction func jumpNextField(_ sender: UIBarButtonItem) {
        let currentIndex = self.responders.index(of: self.activetextField!)!
        print("\(self.responders.index(after: currentIndex))")
        let nextIndex = self.responders.index(after: currentIndex)
        if self.responders.atIndex(index: nextIndex) != nil {
            self.responders[nextIndex].becomeFirstResponder()
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UIBarButtonItem) {
        self.activetextField?.resignFirstResponder()
    }
}

extension UserDataEditorEmbedViewController: UITextFieldDelegate {
    @IBAction func textfiedTouchDown(_ textField: FATextField) {
        //print("tag \(textField.tag) \(String(describing: self.responders.index(of: textField)))")
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activetextField = textField as? FATextField
        //print("tag \(textField.tag) \(String(describing: self.responders.index(of: textField as! FATextField)))")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField as! FATextField) == birthYearTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}


