//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import Photos

class SignalDialogView: UIView, OpalImagePickerControllerDelegate {
    
    var imagepicker = UIImagePickerController()
    
    var type: String!
    
    
    @IBAction func callnow(_ sender: Any) {
        
        if type=="police" {
            let number = DataStore.shared.userData?.policenumber!
            UIApplication.shared.open(URL(string:"tel://"+number!)!);
        }
        if type=="fire" {
            let number = DataStore.shared.userData?.firenumber!
            UIApplication.shared.open(URL(string:"tel://"+number!)!);
        }
        if type=="ambulance" {
            let number = DataStore.shared.userData?.ambulancenumber!
            UIApplication.shared.open(URL(string:"tel://"+number!)!);
        }
        
    }
    
    
    @IBAction func showmap(_ sender: Any) {
        
        if type=="police" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
            let mapController = mainStoryboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            mapController.type = "police_station"
            UIApplication.shared.delegate?.window??.rootViewController = mapController
        }
        if type=="fire" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
            let mapController = mainStoryboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            mapController.type = "fire_station"
            UIApplication.shared.delegate?.window??.rootViewController = mapController
        }
        if type=="ambulance" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
            let mapController = mainStoryboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            mapController.type = "ambulance_station"
            UIApplication.shared.delegate?.window??.rootViewController = mapController
        }
        
    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("SignalDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
