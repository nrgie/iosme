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

class MedListAdapter: Adapter {

    var items: [MedModel]!
    let user = DataStore.shared.userData
    
    var count: Int {
        return items.count
    }
    
    func item(forPosition position: Int) -> Any {
        return items[position]
    }

    func view(forPosition position: Int, convertView: UIView?) -> UIView {
        let result: MedRow! = viewType(forPosition: position).init(frame: CGRect.zero) as? MedRow
        result.fill(with: items[position])
        result.isUserInteractionEnabled = true
        return result
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        return MedRow.self
    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
}
