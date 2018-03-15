//
//  DecideViewController.swift
//  eletmodvaltok
//
//  Created by Tibi on 2017. 06. 15..
//  Copyright © 2017. BlueObject Ltd. All rights reserved.
//

import UIKit
import KYDrawerController

class DecideViewController: UIViewController {

    @IBOutlet weak var triobutton: UIButton!
    @IBOutlet weak var runbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataStore.shared.subscriptions!.forEach { (s: Subscription) in
            if s.programId == "6" {
                runbutton.isEnabled = false
                runbutton.setTitle("Feliratkoztál", for: UIControlState.normal)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func startTrio(_ sender: UIButton) {
        
        let parentNavController = self.parent as! CustomNavigationController
        let rootController: QuestionnarieViewController? = self.storyboard?.instantiateViewController(withIdentifier: "QuestionnarieViewController") as? QuestionnarieViewController
        
        parentNavController.setViewControllers([rootController!], animated: true)
        rootController?.addMenuNavigationItem()
        rootController?.addSearchNavigationItem()
        
    }
    
    @IBAction func startRun(_ sender: UIButton) {
      
        guard let accessToken = DataStore.shared.getAccessToken() else {
            print("missing accestoken")
            return
        }
        
        guard let userId = DataStore.shared.getUserId() else {
            print("missing accestoken")
            return
        }
        
        RestClient.subscribe(for: 6, userId: userId, intensity: 0, subscriptionDate: Int(Date().timeIntervalSince1970), accessToken: accessToken) { (error, result) in
            print("\(String(describing: error))")
         
            if error==nil {
                self.runbutton.setTitle("Feliratkoztál", for: UIControlState.normal)
                self.runbutton.isEnabled=false
                MessageUtils.show(message: "Sikeresen feliratkoztál!", with: "", on: self)
            } else {
                MessageUtils.show(message: "Nem sikerült a feliratkozás.", with: "Error", on: self)
            }
        }
        
    }
    
}
