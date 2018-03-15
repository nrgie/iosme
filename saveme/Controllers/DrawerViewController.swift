//
//  DrawerViewController.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 09..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit
import KYDrawerController

class DrawerViewController : KYDrawerController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleDrawer), name: Constants.Notifications.ToggleMenuNotification, object: nil)
    }
    
    @objc private func toggleDrawer() {
        self.view.endEditing(true)
        if self.drawerState == .closed {
            self.setDrawerState(.opened, animated: true)
        } else {
            self.setDrawerState(.closed, animated: true)
        }
    }
}
