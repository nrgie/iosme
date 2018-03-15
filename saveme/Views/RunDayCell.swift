//
//  RunDayCell.swift
//  eletmodvaltok
//
//  Created by Tibi on 2017. 06. 27..
//  Copyright © 2017. All rights reserved.
//

import UIKit

class RunDayCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var desc: UITextView!
    
    @IBOutlet weak var insideView: UIView!
    
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    
    @IBAction func goto_url1(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: (day?.extra_url1)!)!)
    }
    
    @IBAction func goto_url2(_ sender: UIButton) {
        if day?.extra_url2 == "" {
            UIApplication.shared.openURL(URL(string: (day?.extra_url1)!)!)
        } else {
            UIApplication.shared.openURL(URL(string: (day?.extra_url2)!)!)
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    
    override func layoutSubviews() {
        insideView.layer.cornerRadius = cornerRadius
        //let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        //insideView.layer.masksToBounds = false
        //insideView.layer.shadowColor = shadowColor?.cgColor
        //insideView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        //insideView.layer.shadowOpacity = shadowOpacity
        //insideView.layer.shadowPath = shadowPath.cgPath
    }
    
    
    var day: RunDay? {
        didSet {
            setup()
        }
    }
    
    func setup() {
        
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
    }
    
    func updateDescHeight(heightDifference: CGFloat) {
        
        var newContainerViewFrame: CGRect = self.desc.frame
        
        let containerViewHeight = self.desc.frame.size.height
        print("container view height: \(containerViewHeight)\n")
        
        let newContainerViewHeight = containerViewHeight + heightDifference
        print("new container view height: \(newContainerViewHeight)\n")
        
        let containerViewHeightDifference = containerViewHeight - newContainerViewHeight
        print("container view height difference: \(containerViewHeightDifference)\n")
        
        newContainerViewFrame.size = CGSize(width:self.desc.frame.size.width, height:newContainerViewHeight)
        
        newContainerViewFrame.origin.y - containerViewHeightDifference
        
        self.desc.frame = newContainerViewFrame
    }
    
    
}
