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
    
    func setup() {
        let adapter = AllergyListAdapter()
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
        
        listview.adapter = adapter
        listview.reload()
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
