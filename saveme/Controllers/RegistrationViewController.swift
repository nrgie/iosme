//
//  RegistrationViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "RegistrationEmbed" {
            (segue.destination as! UserDataEditorEmbedViewController).parentVC = self
        } else if segue.identifier == "ModifyDataEmbed" {
            (segue.destination as! UserDataEditorEmbedViewController).parentVC = self
            // TODO: pass user data
            //(segue.destination as! UserDataEditorEmbedViewController).userData = UserData(userName: "Józsi", firstName: "Bácsi", lastName: "Feri", yearOfBirth: "1999", gender: "male")
        }
        
    }
    
    /*override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "RegistrationEmbed" {
            return false
        }
        return true
    }*/
    

}

extension RegistrationViewController: RegistrationEmbedProtocol {
    func scrollViewDidScroll(newHeight: Float) {
        self.heightConstraint.constant = CGFloat(newHeight)
        self.view.layoutIfNeeded()
    }
}
