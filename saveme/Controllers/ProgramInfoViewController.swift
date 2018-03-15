//
//  ProgramInfoViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 15..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class ProgramInfoViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    let htmlStyle = "<html><head></head><body><div style='background-color: rgba(255,255,255,0.65);padding:15px 20px;'>"
    
    var program: Program? {
        didSet {
            let coloredString = htmlStyle.appending((program?.intro ?? "")).appending("</div></body></html>")
            self.webView?.loadHTMLString(coloredString, baseURL: nil)
            self.title = program?.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let coloredString = htmlStyle.appending((program?.intro ?? "")).appending("</div></body></html>")
        self.webView?.loadHTMLString(coloredString, baseURL: nil)
        self.title = program?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
