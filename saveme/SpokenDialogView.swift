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

class SpokenDialogView: UIView {
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    @IBOutlet weak var listview: RollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    let adapter = SpokenListAdapter()
    
    func setup() {
        
        adapter.items = [
            LangModel("English", false),
            LangModel("Spanish", false),
            LangModel("Portuguese", false),
            LangModel("Russian", false),
            LangModel("Hungarian", false),
            LangModel("Italian", false),
            LangModel("French", false),
            LangModel("German", false),
            LangModel("Japanese", false),
            LangModel("Mandarin", false)
        ]
        
        if DataStore.shared.userData?.langs.count == adapter.items.count {
            adapter.items = DataStore.shared.userData?.langs
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: Constants.Notifications.SaveSpoken, object: nil)
        listview.adapter = adapter
        listview.reload()
    }
    
    func save() {
        DataStore.shared.userData?.langs.removeAll()
        DataStore.shared.userData?.langs = adapter.items
        reload()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("SpokenDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
