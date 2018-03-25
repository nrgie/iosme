//
//  TodayViewController.swift
//  SaveMe Quick
//
//  Created by Tibi on 2018. 02. 28..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import UIKit
import NotificationCenter

class QuickViewController: UIViewController, NCWidgetProviding {
   
    @IBOutlet weak var policebtn: UIImageView!
    @IBOutlet weak var sosbtn: UIImageView!
    @IBOutlet weak var firebtn: UIImageView!
    @IBOutlet weak var ambulancebtn: UIImageView!
    
    
    @IBAction func police(_ sender: Any) {
        print("tapped")
        self.extensionContext?.open(URL(string: "saveme://police")! , completionHandler: nil)
    }
    
    @IBAction func ambulance(_ sender: Any) {
                print("tapped")
        self.extensionContext?.open(URL(string: "saveme://ambulance")! , completionHandler: nil)
    }
    
    @IBAction func fire(_ sender: Any) {
                print("tapped")
        self.extensionContext?.open(URL(string: "saveme://fire")! , completionHandler: nil)
    }
    
    @IBAction func sos(_ sender: Any) {
                print("tapped")
        self.extensionContext?.open(URL(string: "saveme://sos")! , completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOSApplicationExtension 10.0, *) {
            extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }
        self.preferredContentSize.height = 100
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
        return UIEdgeInsets.zero
    }
    
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            preferredContentSize = CGSize(width: maxSize.width, height: 100)
        }
        else if activeDisplayMode == .compact {
            preferredContentSize = maxSize
        }
    }

}
