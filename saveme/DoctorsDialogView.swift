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
    
    @IBOutlet weak var listview: RollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        let adapter = DoctorsListAdapter()
        let docs = DataStore.shared.userData?.doctors
        adapter.items = docs
        listview.adapter = adapter
        listview.reload()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Constants.Notifications.ReloadListView, object: nil)
    }
    
    func reload() {
        let adapter = DoctorsListAdapter()
        let docs = DataStore.shared.userData?.doctors
        adapter.items = docs
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
