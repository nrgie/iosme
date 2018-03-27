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
        MedicineEditDialog(item:item).show("Add new record") {_ in }
    }
    
    var item: MedModel!
    
    @IBAction func del(_ sender: Any) {
        var temp = Array<MedModel>();
        for i in (DataStore.shared.userData?.med)! {
            if i.name != self.item.name {
                temp.append(i)
            }
        }
        DataStore.shared.userData?.med = temp
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("MedRow", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: MedModel) {
        self.item = item
        label.text = item.name!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

