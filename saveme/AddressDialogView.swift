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

class AddressDialogView: UIView {
  
    
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var floordoor: UITextField!
    
    @IBAction func ziped(_ sender: Any) {
        user?.zip = zip.text!
        user?.home = zip.text! + ", " + city.text! + " " + street.text! + " " + number.text! + ", " + floordoor.text!
        DataStore.shared.syncUser()
    }
    
    @IBAction func cityed(_ sender: Any) {
        user?.city = city.text!
        user?.home = zip.text! + ", " + city.text! + " " + street.text! + " " + number.text! + ", " + floordoor.text!
        DataStore.shared.syncUser()
    }
    
    @IBAction func streeted(_ sender: Any) {
        user?.street = street.text!
        user?.home = zip.text! + ", " + city.text! + " " + street.text! + " " + number.text! + ", " + floordoor.text!
        DataStore.shared.syncUser()
    }
    
    @IBAction func numbered(_ sender: Any) {
        user?.streetno = number.text!
        user?.home = zip.text! + ", " + city.text! + " " + street.text! + " " + number.text! + ", " + floordoor.text!
        DataStore.shared.syncUser()
    }
    
    @IBAction func floored(_ sender: Any) {
        user?.floordoor = floordoor.text!
        user?.home = zip.text! + ", " + city.text! + " " + street.text! + " " + number.text! + ", " + floordoor.text!
        DataStore.shared.syncUser()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let user = DataStore.shared.userData
    
    func setup() {
        zip.text = user?.zip!
        city.text = user?.city!
        street.text = user?.street!
        number.text = user?.streetno!
        floordoor.text = user?.floordoor!
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("AddressDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
