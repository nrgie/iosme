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
import DropDown

class LangDialogView: UIView {

    let dropDown =  DropDown()

    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var dropbtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func drop(_ sender: Any) {
        
        dropDown.anchorView = dropbtn
        dropDown.dataSource = ["EN", "HU"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            if index == 0 {
                self.flag.image = UIImage(named:"us")
                self.dropbtn.setTitle("EN", for: .normal)
                DataStore.shared.setLang(token:"en")
            }
            if index == 1 {
                self.flag.image = UIImage(named:"hu")
                self.dropbtn.setTitle("HU", for: .normal)
                DataStore.shared.setLang(token:"hu")
            }
        }
        dropDown.show()
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("LangDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        
        let lang = DataStore.shared.getLang()
        if lang == "en"  {
            self.flag.image = UIImage(named:"us")
            self.dropbtn.setTitle("EN", for: .normal)
        }
        
        if lang == ""  {
            self.flag.image = UIImage(named:"us")
            self.dropbtn.setTitle("EN", for: .normal)
        }
        
        if lang == "hu" {
            self.flag.image = UIImage(named:"hu")
            self.dropbtn.setTitle("HU", for: .normal)
        }
        
        addSubview(contentView)
    }
    
    func setup() {
        // The view to which the drop down will appear on
        //lang.anchorView = view // UIView or UIBarButtonItem
        // The list of items to display. Can be changed dynamically
       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
