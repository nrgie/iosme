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

class GuardListAdapter: Adapter {

    var items: [UserData]!
    let user = DataStore.shared.userData
    
    var count: Int {
        return items.count
    }
    
    func item(forPosition position: Int) -> Any {
        return items[position]
    }

    func view(forPosition position: Int, convertView: UIView?) -> UIView {
        let item : UserData = items[position]
        let result: GuardRow! = viewType(forPosition: position).init(frame: CGRect.zero) as? GuardRow
        result.fill(with: items[position])
        result.isUserInteractionEnabled = true
        return result
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        return GuardRow.self
    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
}
