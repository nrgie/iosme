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

class MedicalListAdapter: Adapter {

    var items: [MedicalModel]!
    let user = DataStore.shared.userData
    
    var count: Int {
        return items.count
    }
    
    func item(forPosition position: Int) -> Any {
        return items[position]
    }

    func view(forPosition position: Int, convertView: UIView?) -> UIView {
        let result: MedicalRow! = viewType(forPosition: position).init(frame: CGRect.zero) as? MedicalRow
        result.fill(with: items[position])
        result.isUserInteractionEnabled = true
        return result
    }
    
    func viewType(forPosition position: Int) -> UIView.Type {
        return MedicalRow.self
    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    
}
