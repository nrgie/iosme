//
//  SettingView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class MedicalRow: UIView {

    
    var item: MedicalModel!
    
    @IBOutlet private var label: UILabel!
    
    @IBAction func edit(_ sender: Any) {
        MedEditDialog(item:item).show("Edit Details".localized) {_ in }
    }
    
    @IBAction func del(_ sender: Any) {
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("MedicalRow", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: MedicalModel) {
        self.item = item
        label.text = item.name!
        // fill with userdata
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

