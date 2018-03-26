//
//  SettingsListAdapter.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class AllergyListAdapter: Adapter {

    var items: [AllergyModel]!
    let user = DataStore.shared.userData
    
    var count: Int {
        return items.count
    }
    
    func item(forPosition position: Int) -> Any {
        return items[position]
    }

    func view(forPosition position: Int, convertView: UIView?) -> UIView {
        let result: AllergySwitchView! = viewType(forPosition: position).init(frame: CGRect.zero) as? AllergySwitchView
        result.fill(with: items[position])
        result.isUserInteractionEnabled = true
        return result
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        return SwitchView.self
    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
}
