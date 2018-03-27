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

class MedicineEdit: UIView {

    var item: MedModel!
    

    @IBOutlet weak var qty: UITextField!
    @IBOutlet weak var name: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        if item != nil {
            qty.text = item.qty!
            name.text = item.name!
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("MedicineEdit", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
