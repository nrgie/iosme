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

class MedicalDialogView: UIView {
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    @IBOutlet weak var listview: RollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        let adapter = MedListAdapter()
        let med = DataStore.shared.userData?.med
        adapter.items = med
        adapter.items = DataStore.shared.userData?.med
        listview.adapter = adapter
        listview.reload()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadlist), name: Constants.Notifications.ReloadListView, object: nil)
    }
    
    func reloadlist() {
        let adapter = MedListAdapter()
        let med = DataStore.shared.userData?.med
        adapter.items = med
        adapter.items = DataStore.shared.userData?.med
        listview.adapter = adapter
        listview.reload()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("MedicalDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
