//
//  CustomUIElements.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit


@IBDesignable
class CustomUIButton: UIButton {
    
    @IBInspectable var shadowOpacity: Float = 1.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 1.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 0.0 {
        didSet {
            self.layer.shadowOffset = CGSize(width: self.layer.shadowOffset.width, height: shadowOffsetHeight)
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0.0 {
        didSet {
            self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: self.layer.shadowOffset.height)
        }
    }
}
