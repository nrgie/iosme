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

class MedicalEdit: UIView {

    var item: MedicalModel!
    
    @IBOutlet weak var datum: UITextField!
 
    @IBOutlet weak var des: UITextView!
    
    @IBAction func datumedit(_ sender: Any) {}
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        if item != nil {
            datum.text = item.date!
            des.text = item.name!
        }
        
        self.des.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 0.9).cgColor
        self.des.layer.borderWidth = 1.0;
        self.des.layer.cornerRadius = 5.0;
        
        self.datum.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 0.9).cgColor
        self.datum.layer.borderWidth = 1.0;
        self.datum.layer.cornerRadius = 5.0;
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("MedicalEdit", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
