//
//  RecommendationsWrapperViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 15..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class RecommendationsWrapperViewController: UIViewController {
    
    
    var intensity: Intensity? {
        didSet {
            print("INTENSITY: \(String(describing: intensity?.value))")
        }
    }
    
    var isEditable: Bool = false
    var titleText: String = "Programs.Recommended.Programs".localized

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated:false);
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
        
        if segue.identifier == "RecommendationsEmbed" {
            let recommendations = segue.destination as! RecommendationsViewController
            recommendations.isEditable = self.isEditable
            recommendations.intensity = self.intensity
            recommendations.titleText =  self.titleText
        } else if segue.identifier == "ShowProgramInfo" {
            let programInfo = segue.destination as! ProgramInfoViewController
            programInfo.program = sender as! Program
        }
    }
    

}
