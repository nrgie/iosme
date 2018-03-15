//
//  PopUpViewController.swift
//  eletmodvaltok
//
//  Created by Tibi on 2017. 06. 14..
//  Copyright © 2017. BlueObject Ltd. All rights reserved.
//

import UIKit

class RunViewController: UIViewController {

    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func beginRunProgram(_ sender: UIButton) {
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
                self.startButton.setTitle("Feliratkoztál", for: UIControlState.normal)
                self.startButton.isEnabled = false
                MessageUtils.show(message: "Sikeresen feliratkoztál!", with: "", on: self)
                
            } else {
                MessageUtils.show(message: "Nem sikerült a feliratkozás.", with: "Error", on: self)
            }
             
         }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
