//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import Photos

class HelpDialogView: UIView {
  
    @IBAction func browse(_ sender: Any) {
        guard let url = URL(string: "http://saveme-app.com/faq") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func sendemail(_ sender: Any) {
        let email = "support@saveme-app.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("HelpDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
