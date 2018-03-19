//
//  Wizard1ViewController.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 10..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class ProductView: UIView {
    @IBOutlet private var label: UILabel!
    
    @IBOutlet weak var sw: UISwitch!
    @IBAction func swact(_ sender: Any) {
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let contentView = Bundle.main.loadNibNamed("ProductView", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        addSubview(contentView)
    }
    
    func fill(with product: String) {
        label.text = product
        
        //let grayShade = CGFloat(arc4random_uniform(255)) / 255.0
        //backgroundColor = UIColor(red: grayShade, green: grayShade, blue: grayShade, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ProductsAdapter: Adapter {
    var products: [String]!
    
    var count: Int {
        return products.count
    }
    
    func item(forPosition position: Int) -> Any {
        return products[position]
    }
    
    func view(forPosition position: Int, convertView: UIView?) -> UIView {
        var result: ProductView! = nil
        
        if let reuseView = convertView as? ProductView {
            result = reuseView
        }
        else {
            result = viewType(forPosition: position).init(frame: CGRect.zero) as? ProductView
        }
        
        result.fill(with: products[position])
        
        return result
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        return ProductView.self
    }
}


class Wizard6ViewController : UIViewController {

    var spage: Bool = false
    public func forSettings() {
        spage = true
    }
    
    @IBOutlet weak var listview: RollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        let adapter = ProductsAdapter()
        adapter.products = [

            "SOS alert",
            "Calling Emergency number in the background",
            "SMS notification to Emergency number",
            "Police Emergency Alert",
            "Calling Police Emergency number in the background",
            "SMS notification to Police Emergency number",
            "Fire Department Emergency Alert",
            "Calling Fire Department Emergency number in the background",
            "SMS notification to Fire Department Emergency number",
            "Ambulance Emergency Alert",
            "Calling Ambulance Emergency number in the background",
            "SMS notification to Ambulance Emergency number",
            "Terrorist Attack Emergency Alert",
            "Calling Emergency Number in the background",
            "SMS to Emergency Number",
            
            "Notify your Guardian Angels by phone call in the background",
            "Notify your Guardian Angels by sms in the background",
            "Notify your Guardian Angels by e-mail",
        ]
        
        listview.adapter = adapter
        
        listview.reload()
    }
    
    @IBAction func prev(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard5", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard5") as! Wizard5ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    @IBAction func finish(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
    }
    
}


/*
 
 <string name="perm_sos_title">SOS Alert</string>
 <string name="perm_sos_call">Calling Emergency number in the background</string>
 <string name="perm_sos_sms">SMS notification to Emergency number</string>
 <string name="perm_police_title">Police Emergency Alert</string>
 <string name="perm_police_call">Calling Police Emergency number in the background</string>
 <string name="perm_police_sms">SMS notification to Police Emergency number</string>
 <string name="perm_firedep_title">Fire Department Emergency Alert</string>
 <string name="perm_firedep_call">Calling Fire Department Emergency number in the background</string>
 <string name="perm_firedep_sms">SMS notification to Fire Department Emergency number</string>
 <string name="perm_amb_title">Ambulance Emergency Alert</string>
 <string name="perm_amb_call">Calling Ambulance Emergency number in the background</string>
 <string name="perm_amb_sms">SMS notification to Ambulance Emergency number</string>
 <string name="perm_ta_title">Terrorist Attack Emergency Alert</string>
 <string name="perm_ta_call">Calling Emergency Number in the background</string>
 <string name="perm_ta_sms">SMS to Emergency Number</string>
 <string name="perm_guardcall_title">Notify your Guardian Angels by phone call in the background</string>
 <string name="perm_guardsms_title">Notify your Guardian Angels by e-mail in the background</string>
 <string name="perm_guardemail_title">Notify your Guardian Angels by e-mail</string>
 <string name="guardcall_label">Notification by phone call in the background</string>
 <string name="guardsms_label">Notification by SMSl in the background</string>
 <string name="guardemail_label">Notification by e-mail</string>
 
 
 */
