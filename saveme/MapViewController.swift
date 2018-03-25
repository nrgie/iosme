//
//  GuardsMapViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var locationManager = LocationManager.sharedInstance

    var type: String = "police_station"
    
    @IBOutlet weak var map: GMSMapView!

    @IBAction func backbtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
    }
    
    @IBOutlet weak var backlogo: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 33.86, longitude: 21.20, zoom: 6.0)
        //let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        map.isMyLocationEnabled = true
        map.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 33.86, longitude: 21.20)
        marker.title = "Budapest"
        marker.snippet = ""
        marker.map = map
        
        backlogo.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:)))
        backlogo.addGestureRecognizer(tapGesture)

        map.settings.compassButton = true
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            if error != nil {
                print(error)
            } else {
                AppDelegate.shared.lat = latitude
                AppDelegate.shared.lng = longitude
                print("lat")
                print(latitude)
            }
        }
        
        Gmap.Map.get(place:type)
        
    }
    
    func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




