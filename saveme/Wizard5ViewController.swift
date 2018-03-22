//
//  Wizard1ViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import Contacts
import ContactsUI

class Wizard5ViewController : UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var listview: RollView!
    
    var contactStore = CNContactStore()
    
    var spage: Bool = false
    public func forSettings() {
        spage = true
    }
    
    @IBAction func addnew(_ sender: Any) {
        self.askForContactAccess()
        
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.predicateForEnablingContact = NSPredicate(format: "emailAddresses.@count > 0")
        contactPicker.displayedPropertyKeys = [CNContactNicknameKey, CNContactEmailAddressesKey]
        self.present(contactPicker, animated: true, completion: nil)
        
    }
    
    func askForContactAccess() {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if !access {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        DispatchQueue.main.async(){ () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            let alertController = UIAlertController(title: "Contacts", message: message, preferredStyle: UIAlertControllerStyle.alert)
                            let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in }
                            alertController.addAction(dismissAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            })
            break
        default:
            break
        }
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {

        print(contact)
        let name1 = contact.givenName
        let name3 = contact.familyName
        var phone = ""
        var email = ""
        
        if contact.phoneNumbers.count > 0 {
            phone = ((contact.phoneNumbers[0].value as! CNPhoneNumber).value(forKey: "digits") as? String)!
        }
        
        if contact.emailAddresses.count > 0 {
            email = "\(contact.emailAddresses[0].value)"
        }
        
        let guser = UserData()
        
        guser.name1 = name1
        guser.name3 = name3
        guser.phone = phone
        guser.email = email
        
        //DataStore.shared.userData.guards
        
        //NotificationCenter.default.postNotificationName("addNewContact", object: nil, object: ["contactToAdd": contact])
    }
    
    @IBAction func prev(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard4", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard4") as! Wizard4ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    @IBAction func next(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard6", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard6") as! Wizard6ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    func reload() {
        listview.reload()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.askForContactAccess()  
        
        if spage == true {
            // ide kellene amit elrejtünk. pl. back és save gombok. a lap alján a nevük és a funk hozzá.
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Constants.Notifications.ReloadListView, object: nil)

        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        let adapter = GuardListAdapter()
        adapter.items = [
            //Setting("", "guard1".localized, "", "facebook")
        ]
    
        listview.adapter = adapter
        listview.reload()
    }
    
}
