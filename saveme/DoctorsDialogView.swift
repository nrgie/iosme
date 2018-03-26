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

class DoctorsDialogView: UIView {
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    @IBOutlet weak var listview: RollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        let adapter = DoctorsListAdapter()
        adapter.items = DataStore.shared.userData?.doctors
        listview.adapter = adapter
        listview.reload()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("DoctorDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
