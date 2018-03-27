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

class AllergyDialogView: UIView {
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
    @IBOutlet weak var listview: RollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    let adapter = AllergyListAdapter()
    
    func setup() {
        
        adapter.items = [
            AllergyModel("Pollen".localized, false),
            AllergyModel("Animal dander".localized, false),
            AllergyModel("Domestic dust".localized, false),
            AllergyModel("Gluten".localized, false),
            AllergyModel("Shellfish".localized, false),
            AllergyModel("Eggs".localized, false),
            AllergyModel("Fish".localized, false),
            AllergyModel("Peanut".localized, false),
            AllergyModel("Soy".localized, false),
            AllergyModel("Milk (lactose)".localized, false),
            AllergyModel("Nuts".localized, false),
            AllergyModel("Celery".localized, false),
            AllergyModel("Mustard".localized, false),
            AllergyModel("Sesame seed".localized, false),
            AllergyModel("Sulfur-dioxide".localized, false),
            AllergyModel("Lupine".localized, false),
            AllergyModel("Molluscs".localized, false)
        ]
        
        if DataStore.shared.userData?.allergies.count == adapter.items.count {
            adapter.items = DataStore.shared.userData?.allergies
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: Constants.Notifications.SaveAllergies, object: nil)
        listview.adapter = adapter
        listview.reload()
    }
    
    func save() {
        DataStore.shared.userData?.allergies.removeAll()
        DataStore.shared.userData?.allergies = adapter.items
        reload()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("AllergyDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
