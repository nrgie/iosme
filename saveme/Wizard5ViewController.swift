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
import EPContactsPicker

class Wizard5ViewController : UIViewController, EPPickerDelegate {

    @IBOutlet weak var listview: RollView!
    
    var contactStore = CNContactStore()
    
    var spage: Bool = false
    public func forSettings() {
        spage = true
    }
    
    @IBAction func addnew(_ sender: Any) {
        self.askForContactAccess()
        let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:true, subtitleCellType: SubtitleCellValue.email)
        let navigationController = UINavigationController(rootViewController: contactPickerScene)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func epContactPicker(_: EPContactsPicker, didContactFetchFailed error : NSError) {
        print("Failed with error \(error.description)")
    }
    
    func epContactPicker(_: EPContactsPicker, didSelectContact contact : EPContact) {

        let guser = UserData()
        guser.name1 = contact.firstName
        guser.name3 = contact.lastName
        
        /*
         birthday = Calendar(identifier: Calendar.Identifier.gregorian).date(from: birthdayDate)
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = EPGlobalConstants.Strings.birdtdayDateFormat
         //Example Date Formats:  Oct 4, Sep 18, Mar 9
         birthdayString = dateFormatter.string(from: birthday!)
         */
        
        if contact.phoneNumbers.count > 0 {
            guser.phone = contact.phoneNumbers[0].phoneNumber
        }
        
        if contact.emails.count > 0 {
            guser.email = contact.emails[0].email
        }
        guser.enabled = false
    
        DataStore.shared.userData?.guards.append(guser)
        self.reload()
        
    }
    
    func epContactPicker(_: EPContactsPicker, didCancel error : NSError) {
        print("User canceled the selection");
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
        
        if spage == true {
            // ide kellene amit elrejtünk. pl. back és save gombok. a lap alján a nevük és a funk hozzá.
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Constants.Notifications.ReloadListView, object: nil)

        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        let adapter = GuardListAdapter()
        adapter.items = DataStore.shared.userData?.guards
    
        listview.adapter = adapter
        listview.reload()
    }
    
}
