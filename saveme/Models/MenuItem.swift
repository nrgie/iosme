//
//  MenuItem.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation

struct MenuItem {
    var titleKey: String?
    var urlString: String?
    var type: String?
    var placeholder: Bool!
    
    init(titleKey: String = "", urlString: String = "", placeholder: Bool = false, type: String = Constants.MenuItemType.ShowWebContent) {
        self.titleKey = titleKey
        self.urlString = urlString
        self.placeholder = placeholder
        self.type = type
    }
}
