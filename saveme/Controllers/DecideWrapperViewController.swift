//
//  DecideWrapperViewController.swift
//  eletmodvaltok
//
//  Created by Tibi on 2017. 06. 15..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class DecideWrapperViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            //self.navigationItem.setHidesBackButton(true, animated:false);
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
            if segue.identifier == "DecideEmbed" {
                let recommendations = segue.destination as! DecideViewController
                
            }
        }
    
}
