//
//  SettingView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit


class DoctorRow: UIView {

    var item: DoctorModel!
    
    @IBOutlet private var label: UILabel!
    
    @IBAction func del(_ sender: Any) {
        var temp = Array<DoctorModel>();
        for i in (DataStore.shared.userData?.doctors)! {
            if i.name != self.item.name {
                temp.append(i)
            }
        }
        DataStore.shared.userData?.doctors = temp
        self.removeFromSuperview()
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    @IBAction func edit(_ sender: Any) {
        DoctorEditDialog(item:item).show("Add new record") {_ in }
    }
    
    @IBAction func call(_ sender: Any) {
        UIApplication.shared.open(URL(string:"tel://"+item.phone)!);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("DoctorRow", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: DoctorModel) {
        self.item = item
        label.text = item.name!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

