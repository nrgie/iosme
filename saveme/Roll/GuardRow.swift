//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class GuardRow: UIView {
    
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var status: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("GuardRow", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: UserData) {
        key.text = "guardian".localized
        //flag.image = UIImage(named:item.icon!)
        value.text = item.name1! + " " + item.name2! + " " + item.name3!
        
        UITapGestureRecognizer(addToView: flag) {
            CountryDialog().show("Select country for guardian") {_ in }
        }

        UITapGestureRecognizer(addToView: status) {
            let alert = UIAlertController(title: "Guardian".localized, message: "The status of this Guradian is Pending".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
