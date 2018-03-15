//
//  MenuItemCell.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit

class MenuItemCell : UITableViewCell {

    @IBOutlet weak var itemTitleLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.itemTitleLabel.textColor = UIColor(netHex: 0xF2685F)
        } else {
            self.itemTitleLabel.textColor = .white
        }
    }
}
