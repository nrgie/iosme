//
//  SettingView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class MedRow: UIView {

    @IBOutlet private var label: UILabel!
    @IBAction func edit(_ sender: Any) {
        // ide egy edit dialog feltöltve
       // MedEditDialog(item:)
    }
    @IBAction func del(_ sender: Any) {
        // ide egy confim a delhez
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("MedRow", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: MedModel) {
        label.text = item.name!
        // fill with userdata
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

