//
//  BaseViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10.
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class BaseViewController : UIViewController {


    @IBOutlet weak var helpButton: UIImageView!
    @IBOutlet weak var settingsButton: UIImageView!
    @IBOutlet weak var guardsButton: UIImageView!
    @IBOutlet weak var medInfoButton: UIImageView!
    
    @IBOutlet weak var tabtn: UIImageView!
    
    @IBOutlet weak var firebtn: UIImageView!
    @IBOutlet weak var ambulancebtn: UIImageView!
    @IBOutlet weak var policebtn: UIImageView!
    @IBOutlet weak var sosbtn: UIImageView!
    
    
    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
        
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
    }
    
    
    override func viewDidLoad() {
        let helptap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.helpTap))
        let helplongtap = UILongPressGestureRecognizer(target: self, action: #selector(BaseViewController.helpLongTapped))

        let settingstap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.settingsTap))
        let guardstap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.guardsTap))
        let medinfotap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.medinfoTap))
        
        let settingslongtap = UILongPressGestureRecognizer(target: self, action: #selector(BaseViewController.helpLongTapped))
        let guardslongtap = UILongPressGestureRecognizer(target: self, action: #selector(BaseViewController.helpLongTapped))
        let medinfolongtap = UILongPressGestureRecognizer(target: self, action: #selector(BaseViewController.helpLongTapped))
        
        helptap.numberOfTapsRequired = 1
        helpButton.addGestureRecognizer(helptap)
        helpButton.addGestureRecognizer(helplongtap)
        helpButton.isUserInteractionEnabled = true

        settingstap.numberOfTapsRequired = 1
        settingsButton.addGestureRecognizer(settingstap)
        settingsButton.addGestureRecognizer(settingslongtap)
        settingsButton.isUserInteractionEnabled = true
        
        guardstap.numberOfTapsRequired = 1
        guardsButton.addGestureRecognizer(guardstap)
        guardsButton.addGestureRecognizer(guardslongtap)
        guardsButton.isUserInteractionEnabled = true
        
        medinfotap.numberOfTapsRequired = 1
        medInfoButton.addGestureRecognizer(medinfotap)
        medInfoButton.addGestureRecognizer(medinfolongtap)
        medInfoButton.isUserInteractionEnabled = true
        
    }
    
    func helpTap(gestureRecognizer: UITapGestureRecognizer){
        
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the popup dialog default view"
        let image = UIImage(named: "logo")
        let popup = PopupDialog(title: title, message: message, image: image)
        let buttonOne = CancelButton(title: "CANCEL") {
            print("You canceled the car dialog.")
        }
        popup.addButton(buttonOne)
        //popup.addButtons([buttonOne])
        UIApplication.shared.keyWindow?.rootViewController?.present(popup, animated: true, completion: nil)
        
    }

    func guardsTap(gestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "guardsMap", bundle: nil)
        let mapController = mainStoryboard.instantiateViewController(withIdentifier: "GuardsMapViewController") as! GuardsMapViewController
        UIApplication.shared.delegate?.window??.rootViewController = mapController
    
    }
    
    
    func settingsTap(gestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
        
    }
    
    func medinfoTap(gestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("scrolldown infobox")
        
        /*
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "medical", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "medical") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
        */
        self.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
        
    }
    
    func helpLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        print("long tapped")
        // send sos
        
        self.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
        guard let number = URL(string:"tel://100") else { return; }
        UIApplication.shared.open(number);
    }
    
    
    func TALongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        print("long tapped")
        // send sos
        
        self.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
        guard let number = URL(string:"tel://100") else { return; }
        UIApplication.shared.open(number);
    }
    func PoliceLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        print("long tapped")
        // send sos
        self.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
        guard let number = URL(string:"tel://100") else { return; }
        UIApplication.shared.open(number);
    }
    func AmbLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        print("long tapped")
        // send sos
        self.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
        guard let number = URL(string:"tel://100") else { return; }
        UIApplication.shared.open(number);
    }
    func FireLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        print("long tapped")
        // send sos
        self.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
        guard let number = URL(string:"tel://100") else { return; }
        UIApplication.shared.open(number);
    }
    
    func SOSLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        print("long tapped")
        // send sos
        self.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
        guard let number = URL(string:"tel://100") else { return; }
        UIApplication.shared.open(number);
    }
    
}
