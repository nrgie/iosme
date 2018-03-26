//
//  SettingCell.swift
//  saveme
//
//  Created by Tibi on 2018. 01. 17..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import UIKit
import PopupDialog

class SettingCell: UITableViewCell, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var sepText: UILabel!
    @IBOutlet weak var val: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var key: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    var imagepicker = UIImagePickerController()
    
    override func layoutSubviews() {
        //insideView.layer.cornerRadius = cornerRadius
        //let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        //insideView.layer.masksToBounds = false
        //insideView.layer.shadowColor = shadowColor?.cgColor
        //insideView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        //insideView.layer.shadowOpacity = shadowOpacity
        //insideView.layer.shadowPath = shadowPath.cgPath
    }
    
    
    var setting: Setting? {
        didSet {
            setup()
        }
    }
    
    func setup() {
        
        if setting?.action == "separator" {
        
            self.val.isHidden = true
            self.icon.isHidden = true
            self.go.isHidden = true
            self.key.isHidden = true
            
            self.separator.isHidden = false
            
            self.sepText.text = setting?.key
            
        } else {
        
            self.sepText.text = setting?.action
            
            self.key.text = setting?.key
            self.val.text = setting?.value
            
            self.separator.isHidden = true
            
            self.val.isHidden = false
            self.icon.isHidden = false
            self.go.isHidden = false
            self.key.isHidden = false
        
        }
        
        
        self.key.isUserInteractionEnabled = true
        self.go.isUserInteractionEnabled = true
        self.icon.isUserInteractionEnabled = true
        
        self.key.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(SettingCell.tap)))
        self.icon.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(SettingCell.tap)))
        self.go.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(SettingCell.tap)))
        
        if self.val.text == "" {
            self.updateKeyHeight(heightDifference: 50.0)
        }
        
        
        /*
        self.bg.sd_setImage(with: URL(string: self.day?.img ?? ""))
        self.title.text = day?.title
        var desc = day?.content.replacingOccurrences(of: "<[^>]*>", with: "", options: .regularExpression, range: nil)
        desc = desc?.replacingOccurrences(of: (day?.title)!, with: "")
        desc = desc?.replacingOccurrences(of: "\r\n", with: "")
        desc = desc?.replacingOccurrences(of: "&nbsp;", with: "")
        
        self.desc.text = desc
        
        if day?.extra_url2 != "" {
            self.button1.isHidden = false
            self.button1.setTitle(day?.extra_url1_text, for: UIControlState.normal)
            self.button2.setTitle(day?.extra_url2_text, for: UIControlState.normal)
        } else {
            self.button2.setTitle(day?.extra_url1_text, for: UIControlState.normal)
            self.button1.isHidden = true
            //updateDescHeight(heightDifference: 50.0)
            //self.layoutIfNeeded()
        }
            */
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
    }
    
    func updateKeyHeight(heightDifference: CGFloat) {
    
        var newContainerViewFrame: CGRect = self.key.frame
        
        let containerViewHeight = self.key.frame.size.height
        print("container view height: \(containerViewHeight)\n")
        
        let newContainerViewHeight = containerViewHeight + heightDifference
        print("new container view height: \(newContainerViewHeight)\n")
        
        let containerViewHeightDifference = containerViewHeight - newContainerViewHeight
        print("container view height difference: \(containerViewHeightDifference)\n")
        
        newContainerViewFrame.size = CGSize(width:self.key.frame.size.width, height:newContainerViewHeight)
        
        //newContainerViewFrame.origin.y - containerViewHeightDifference
        
        //self.key.frame = newContainerViewFrame

    }
    
    func tap(){
        print(self.key.text!)
        print(self.sepText.text!)

        
        if self.sepText.text == "w1" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard1", bundle: nil)
            let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard1") as! Wizard1ViewController
            c.spage = true
            UIApplication.shared.delegate?.window??.rootViewController = c
        }
        if self.sepText.text == "w2" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard2", bundle: nil)
            let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard2") as! Wizard2ViewController
            c.spage = true
            UIApplication.shared.delegate?.window??.rootViewController = c
        }
        if self.sepText.text == "w3" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard3", bundle: nil)
            let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard3") as! Wizard3ViewController
            c.spage = true
            UIApplication.shared.delegate?.window??.rootViewController = c
        }
        if self.sepText.text == "w4" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard4", bundle: nil)
            let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard4") as! Wizard4ViewController
            c.spage = true
            UIApplication.shared.delegate?.window??.rootViewController = c
        }
        if self.sepText.text == "w5" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard5", bundle: nil)
            let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard5") as! Wizard5ViewController
            c.spage = true
            UIApplication.shared.delegate?.window??.rootViewController = c
        }
        if self.sepText.text == "w6" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard6", bundle: nil)
            let c = mainStoryboard.instantiateViewController(withIdentifier: "wizard6") as! Wizard6ViewController
            c.spage = true
            UIApplication.shared.delegate?.window??.rootViewController = c
        }
        
        
        if self.sepText.text == "studentmode" {
            print("EXIT!")
            
            // Prepare the popup assets
            let title = "THIS IS THE DIALOG TITLE"
            let message = "This is the message section of the popup dialog default view"
            let image = UIImage(named: "logo")
            
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, image: image)
            
            // Create buttons
            let buttonOne = CancelButton(title: "CANCEL") {
                print("You canceled the car dialog.")
            }
            
            // This button will not the dismiss the dialog
            let buttonTwo = DefaultButton(title: "ADMIRE CAR", dismissOnTap: false) {
                print("What a beauty!")
            }
            
            let buttonThree = DefaultButton(title: "BUY CAR", height: 60) {
                print("Ah, maybe next time :)")
            }
            
            // Add buttons to dialog
            // Alternatively, you can use popup.addButton(buttonOne)
            // to add a single button
            popup.addButtons([buttonOne, buttonTwo, buttonThree])
            
            // Present dialog
            //self.present(popup, animated: true, completion: nil)
            
            UIApplication.shared.keyWindow?.rootViewController?.present(popup, animated: true, completion: nil)
            
        }
        
        if self.sepText.text == "imagepicker" {
            
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                print("Capture img")
                
                imagepicker.delegate = self
                imagepicker.sourceType = .savedPhotosAlbum
                imagepicker.allowsEditing = false
                
                UIApplication.shared.keyWindow?.rootViewController?.present(imagepicker, animated: true, completion: nil)
                
            }
            
        }
        
        
        if self.sepText.text == "exit" {
            
            DataStore.shared.clearData()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Splash", bundle: nil)
            let baseController = mainStoryboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
            UIApplication.shared.delegate?.window??.rootViewController = baseController
            
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        //self.dismiss(animated:true, completion: { () -> Void in } )
    }
}
