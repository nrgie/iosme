//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class SettingAvatarView: UIView {
    

    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let contentView = Bundle.main.loadNibNamed("SettingAvatar", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        //contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(contentView)
    }
    
    func fill(with item: Setting) {
        key.text = item.key
        value.text = DataStore.shared.userData?.name!
        
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("avatar.jpg")
            let image    = UIImage(contentsOfFile: imageURL.path)
            // Do whatever you want with the image
            if(image != nil) {
                avatar.image = image
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
