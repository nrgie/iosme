import Foundation
import UIKit
//import FontAwesome_swift

class Theme {
    
    static let shared: Theme = {
        let instance = Theme()
        //instance.printFontFamilies()
        return instance
    }()
    
    private init() {
        
        /*
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navigationBarBG")!.resizableImage(withCapInsets: UIEdgeInsetsMake(30, 0, 30, 0), resizingMode: .stretch), for: .default)
        */
        
        //UINavigationBar.appearance().tintColor = .white
        
        //UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : self.robotoFont(size: 16.0), NSForegroundColorAttributeName: UIColor.white]
        //UINavigationBar.appearance().shadowImage = UIImage()
        
        
        (UIApplication.shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = UIColor(netHex: 0x000000)
        
        //let backImage: UIImage =  UIImage.fontAwesomeIcon(name: .arrowLeft, textColor: UIColor.white, size: CGSize(width: 22.0, height: 22.0))
        
        //UINavigationBar.appearance().backIndicatorImage = backImage
        //UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0.0,vertical: -66.0), for: .default)
        
        
    }
    
    func robotoFont(size: CGFloat) -> UIFont {
        return UIFont(name: "RobotoCondensed-Bold", size: size)!
    }
    
    private func printFontFamilies() {
        for fontFamily in UIFont.familyNames {
            print("Font family name = \(fontFamily as String)");
            for fontName in UIFont.fontNames(forFamilyName: fontFamily){
                print("- Font name = \(fontName)");
            }
            print("\n");   
        }
        
    }
}
