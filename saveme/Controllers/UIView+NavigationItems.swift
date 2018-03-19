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


extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
