
import Foundation
import UIKit

@IBDesignable
class CustomButton : UIButton {
    
    override func awakeFromNib() {
        self.setTitleColor(UIColor(netHex: 0xBDC3C7), for: .disabled)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
        self.titleLabel?.textAlignment = .center
    }
}
