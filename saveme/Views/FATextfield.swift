//
//  FATextfield.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class FATextField : UITextField {

    /*
    @IBInspectable var iconName: String = String.fontAwesomeIcon(name: .apple) {
        didSet {
            //self.iconLabel.text = String.fontAwesomeIcon(code: self.iconName)
        }
    }
    */
    
    @IBInspectable var iconSize: CGFloat = 16.0 {
        didSet {
            //self.iconLabel.font = UIFont.fontAwesome(ofSize: self.iconSize)
        }
    }
    
    @IBInspectable var iconBackgroundColor: UIColor = .red {
        didSet {
            self.iconLabelWrapperView?.backgroundColor = self.iconBackgroundColor
        }
    }
    
    @IBInspectable var iconColor: UIColor = .white {
        didSet {
            self.iconLabel.textColor = self.iconColor
        }
    }
    
    
    var iconLabel: UILabel = UILabel()
    private var leftViewContainer: UIView?
    private var iconLabelWrapperView: UIView?

    override func awakeFromNib() {
        self.tintColor = UIColor(red: 242.0/255.0, green: 104.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        self.iconLabel.frame = CGRect(x: 0, y: 0, width: rect.height, height: rect.height)
        self.iconLabel.textAlignment = .center
        if self.leftViewContainer == nil {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.18
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowRadius = 4
            self.layer.masksToBounds = false
            if self.iconLabelWrapperView == nil {
                self.iconLabelWrapperView = UIView(frame: CGRect(x: 0, y: 0, width: rect.height, height: rect.height))
                self.iconLabelWrapperView?.addSubview(self.iconLabel)
            }
            self.leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: rect.height + 8.0, height: rect.height))
            self.leftViewContainer?.addSubview(self.iconLabelWrapperView!)
            self.leftView = self.leftViewContainer
            self.leftViewMode = .always
        }
        self.iconLabelWrapperView?.backgroundColor = self.iconBackgroundColor
    }
}
