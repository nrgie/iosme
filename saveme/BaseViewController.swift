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

        let TAlongtap = UILongPressGestureRecognizer(target: self, action: #selector(self.TALongTapped))
        let Pollongtap = UILongPressGestureRecognizer(target: self, action: #selector(self.PoliceLongTapped))
        let Amblongtap = UILongPressGestureRecognizer(target: self, action: #selector(self.AmbLongTapped))
        let Firelongtap = UILongPressGestureRecognizer(target: self, action: #selector(self.FireLongTapped))
        let Soslongtap = UILongPressGestureRecognizer(target: self, action: #selector(self.SOSLongTapped))
        
        let TAtap = UITapGestureRecognizer(target: self, action: #selector(self.tatap))
        let Poltap = UITapGestureRecognizer(target: self, action: #selector(self.poltap))
        let Firetap = UITapGestureRecognizer(target: self, action: #selector(self.firetap))
        let Ambtap = UITapGestureRecognizer(target: self, action: #selector(self.ambtap))
        
        let settingstap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.settingsTap))
        let guardstap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.guardsTap))
        let medinfotap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.medinfoTap))
      
        helptap.numberOfTapsRequired = 1
        helpButton.addGestureRecognizer(helptap)
        helpButton.isUserInteractionEnabled = true

        settingstap.numberOfTapsRequired = 1
        settingsButton.addGestureRecognizer(settingstap)
        settingsButton.isUserInteractionEnabled = true
        
        guardstap.numberOfTapsRequired = 1
        guardsButton.addGestureRecognizer(guardstap)
        guardsButton.isUserInteractionEnabled = true
        
        medinfotap.numberOfTapsRequired = 1
        medInfoButton.addGestureRecognizer(medinfotap)
        medInfoButton.isUserInteractionEnabled = true

        TAtap.numberOfTapsRequired = 1
        tabtn.addGestureRecognizer(TAtap)
        tabtn.addGestureRecognizer(TAlongtap)
        tabtn.isUserInteractionEnabled = true
        
        Poltap.numberOfTapsRequired = 1
        policebtn.addGestureRecognizer(Poltap)
        policebtn.addGestureRecognizer(Pollongtap)
        policebtn.isUserInteractionEnabled = true
        
        Firetap.numberOfTapsRequired = 1
        firebtn.addGestureRecognizer(Firetap)
        firebtn.addGestureRecognizer(Firelongtap)
        firebtn.isUserInteractionEnabled = true
     
        Ambtap.numberOfTapsRequired = 1
        ambulancebtn.addGestureRecognizer(Ambtap)
        ambulancebtn.addGestureRecognizer(Amblongtap)
        ambulancebtn.isUserInteractionEnabled = true
        
        sosbtn.addGestureRecognizer(Soslongtap)
        sosbtn.isUserInteractionEnabled = true
        
        if AppDelegate.shared.doAfterLaunch != "" {
            // nem reagál...
            let alert = UIAlertController(title: "INFOBOX".localized, message: AppDelegate.shared.doAfterLaunch, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func helpTap(gestureRecognizer: UITapGestureRecognizer) {
        HelpDialog(showCancelButton:false).show("PLEASE SELECT HELP") {_ in }
    }

    func guardsTap(gestureRecognizer: UITapGestureRecognizer){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "guardsMap", bundle: nil)
        let mapController = mainStoryboard.instantiateViewController(withIdentifier: "GuardsMapViewController") as! GuardsMapViewController
        UIApplication.shared.delegate?.window??.rootViewController = mapController
    }
    
    func settingsTap(gestureRecognizer: UITapGestureRecognizer){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "QuickSettings", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "QuickSettings") as! QuickSettingsViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    func medinfoTap(gestureRecognizer: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
    }
    
    func tatap(gestureRecognizer: UITapGestureRecognizer) {}
    
    func poltap(gestureRecognizer: UITapGestureRecognizer) {
        SignalDialog(showCancelButton:false).show("SELECT QUICK ACTION", type:"police") {_ in }
    }
    func firetap(gestureRecognizer: UITapGestureRecognizer) {
        SignalDialog(showCancelButton:false).show("SELECT QUICK ACTION", type:"fire") {_ in }
    }
    func ambtap(gestureRecognizer: UITapGestureRecognizer) {
        SignalDialog(showCancelButton:false).show("SELECT QUICK ACTION", type:"ambulance") {_ in }
    }

    func TALongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        AppDelegate.shared.sendSOS(type: "ta")
    }
    func PoliceLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        AppDelegate.shared.sendSOS(type: "police")
    }
    func AmbLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        AppDelegate.shared.sendSOS(type: "ambulnace")
    }
    func FireLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        AppDelegate.shared.sendSOS(type: "fire")
    }
    
    func SOSLongTapped(gestureRecognizer: UILongPressGestureRecognizer){
        AppDelegate.shared.sendSOS(type: "sos")
    }
    
    /*
     
     for load and parse local JSON
     
     var list = [GMUWeightedLatLng]()
     do {
     // Get the data: latitude/longitude positions of police stations.
     if let path = Bundle.main.url(forResource: "police_stations", withExtension: "json") {
     let data = try Data(contentsOf: path)
     let json = try JSONSerialization.jsonObject(with: data, options: [])
     if let object = json as? [[String: Any]] {
     for item in object {
     let lat = item["lat"]
     let lng = item["lng"]
     let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: 1.0)
     list.append(coords)
     }
     } else {
     print("Could not read the JSON.")
     }
     }
     } catch {
     print(error.localizedDescription)
     }
     
     */
    
}
