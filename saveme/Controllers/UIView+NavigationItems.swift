//
//  UIView+NavigationItems.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 09..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit
import KYDrawerController

extension UIViewController {
    
    func addMenuNavigationItem() {
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(toggleMenu))
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    func addBackNavigationItem() {
        //let backButton = UIBarButtonItem(title: String.fontAwesomeIcon(name: .arrowLeft), style: UIBarButtonItemStyle.done, target: self, action: #selector(navigateBack))
        //let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        //backButton.setTitleTextAttributes(attributes, for: .normal)
        //backButton.title = String.fontAwesomeIcon(name: .arrowLeft)
        //self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addSearchNavigationItem() {
        if self.navigationController != nil {
            let searchView = SearchInputView(frame: CGRect(x: 0.0, y: 0.0, width: (self.navigationController?.navigationBar.frame.width)! / 2.0, height: 22.0))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchView)
        }

    }
    
    @objc private func toggleMenu() {
        NotificationCenter.default.post(name: Constants.Notifications.ToggleMenuNotification, object: nil)
    }
    
    @objc private func showInfo() {
        NotificationCenter.default.post(name: Constants.Notifications.ShowInfoNotification, object: nil)
    }
    
    @objc private func navigateBack() {
        NotificationCenter.default.post(name: Constants.Notifications.GoBackNotification, object: nil)
    }
    
}
