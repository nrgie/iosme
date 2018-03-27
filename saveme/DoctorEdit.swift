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

class DoctorEdit: UIView {

    var item: DoctorModel!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var special: UITextField!
    @IBOutlet weak var custom: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        if item != nil {
            name.text = item.name!
            email.text = item.email!
            phone.text = item.phone!
            special.text = item.special!
            custom.text = item.custom!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("DoctorEdit", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
