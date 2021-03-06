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

class FullNameView: UIView, OpalImagePickerControllerDelegate {
    
    var imagepicker = UIImagePickerController()
    
    func checkPermission() {

        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }

    }
    
    @IBOutlet weak var av: UIImageView!
    @IBAction func editpic(_ sender: Any) {
        
        checkPermission()
        
        let imagePicker = OpalImagePickerController()
        imagePicker.maximumSelectionsAllowed = 1
        imagePicker.saveTo = "avatar.jpg"
        
        NotificationCenter.default.post(name: Constants.Notifications.CloseDialog, object: nil, userInfo: nil)
        
        imagePicker.imagePickerDelegate = self as OpalImagePickerControllerDelegate
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var n1txt: UITextField!
    @IBOutlet weak var n2txt: UITextField!
    @IBOutlet weak var n3txt: UITextField!
    
    @IBAction func n1(_ sender: Any) {
        DataStore.shared.userData?.name1 = n1txt.text!
        reload()
    }
    
    @IBAction func n2(_ sender: Any) {
        DataStore.shared.userData?.name2 = n2txt.text!
        reload()
    }
    
    @IBAction func n3(_ sender: Any) {
        DataStore.shared.userData?.name3 = n3txt.text!
        DataStore.shared.userData?.name = n1txt.text! + " " + n2txt.text! + " " + n3txt.text!
        reload()
    }
    
    func reload() {
        NotificationCenter.default.post(name: Constants.Notifications.ReloadListView, object: nil, userInfo: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        n1txt.text = DataStore.shared.userData?.name1!
        n2txt.text = DataStore.shared.userData?.name2!
        n3txt.text = DataStore.shared.userData?.name3!
      
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("avatar.jpg")
            let image    = UIImage(contentsOfFile: imageURL.path)
            if(image != nil) {
                av.image = image
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("FullName", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
