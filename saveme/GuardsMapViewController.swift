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

class GuardsMapViewController: UIViewController {

    let mapback : MapBackView = MapBackView(frame: CGRect.zero)
    
    var locationManager = LocationManager.sharedInstance
    
    let didFindMyLocation = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 33.86, longitude: 21.20)
        marker.title = "Budapest"
        marker.snippet = ""
        marker.map = mapView

        self.view.addSubview(mapback)
        self.view.bringSubview(toFront: mapback)
        
        mapback.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:)))
        mapback.addGestureRecognizer(tapGesture)
        

        
        //mapback.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        let mapInsets = UIEdgeInsets(top: 80.0, left: 0.0, bottom: 45.0, right: 0.0)
        mapView.padding = mapInsets
        
        // GOOGLE MAPS SDK: COMPASS
        mapView.settings.compassButton = true
        
        // GOOGLE MAPS SDK: USER'S LOCATION
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            if error != nil {
                print(error)
            } else {
                var lat = latitude
                var lng = longitude
                print("lat")
                print(latitude)
            }
        }
        
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




