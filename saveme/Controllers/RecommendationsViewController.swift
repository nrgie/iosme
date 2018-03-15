//
//  RecommendationsViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 12..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit
import KYDrawerController

class RecommendationsViewController: UITableViewController {
    
    @IBOutlet var moveView: UITableViewCell!
    @IBOutlet var eatView: UITableViewCell!
    @IBOutlet var soulView: UITableViewCell!
    
    @IBOutlet var moveTickImageView: UIImageView!
    @IBOutlet var eatTickImageView: UIImageView!
    @IBOutlet var soulTickImageView: UIImageView!
    
    @IBOutlet var beginProgramButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    
    var intensity: Intensity! {
        didSet {
            print("INTENSITY: \(String(describing: intensity?.slug))")
        }
    }
    var titleText: String? {
        didSet {
            titleLabel?.text = titleText
        }
    }
    
    var isEditable: Bool = false
    
    var data: [Program]? = []
    var filtered: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if isEditable == true {
            self.tableView.allowsMultipleSelection = true
        } else {
            self.tableView.allowsMultipleSelection = false
        }
        titleLabel?.text = titleText
        
        for p in DataStore.shared.programs! {
            if p.active == true {
                data?.append(p)
            }
        }
        
        if isEditable == false {
            // Add subscribed
            var array: [String] = []
            for s in DataStore.shared.subscriptions! {
                for d: Program in data! {
                    if s.programId == d.id {
                        array.append(d.id)
                    }
                }
            }
            filtered = array
        } else {
            // Add all for default
            var array: [String] = []
            for d: Program in data! {
                
                //skip run program ID.
                
                if d.active == true && d.id != "6" {
                    array.append(d.id)
                }
            }
            filtered = array
            self.tableView.reloadData()
            let totalRows = tableView.numberOfRows(inSection: 0)
            for row in 0..<totalRows {
                print("\nselect row:\(row)")
                tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
            }
            self.checkforSelectedPrograms(self.tableView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func beginProgram(_ sender: UIButton) {
        guard let accessToken = DataStore.shared.getAccessToken() else {
            print("missing accestoken")
            return
        }
        
        guard let userId = DataStore.shared.getUserId() else {
            print("missing accestoken")
            return
        }
        
        for ip in self.tableView.indexPathsForSelectedRows ?? [] {
            let program = data?[ip.row]
            print("\(String(describing: program?.id))")
            if program?.id == "1" { // mozgás
                RestClient.subscribe(for: Int((program?.id)!) ?? 1, userId: userId, intensity: intensity.value, subscriptionDate: Int(Date().timeIntervalSince1970), accessToken: accessToken) { (error, result) in
                    print("\(String(describing: error))")
                }
            } else {
                RestClient.subscribe(for: Int((program?.id)!) ?? 0, userId: userId, intensity: 0, subscriptionDate: Int(Date().timeIntervalSince1970), accessToken: accessToken) { (error, result) in
                    print("\(String(describing: error))")
                }
            }
        }
        
        let parent = self.parent as! RecommendationsWrapperViewController
        let parentNavController = parent.parent as! CustomNavigationController
        
        
        RestClient.getUserData(userId:  DataStore.shared.getUserId()!, accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (error: String?, userDataResponse: UserDataResponse?) in
            
            if error == nil {
                DataStore.shared.userData = userDataResponse?.userData.first
                DataStore.shared.subscriptions = userDataResponse?.userSubscriptions
                RestClient.getPrograms(accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (err: String?, programs: [Program]?) in
                    if programs != nil {
                        DataStore.shared.programs = programs
                        NotificationCenter.default.post(name: Constants.Notifications.ProgramUpdatedNotification, object: nil)
                        
                        
                        let rootController = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController") as? MyProfileViewController
                        parentNavController.setViewControllers([rootController!], animated: true)
                        rootController?.addMenuNavigationItem()
                        rootController?.addSearchNavigationItem()
                    }
                })
                
                
            } else {
                MessageUtils.show(message: error!, with: "Error".localized, on: self)
            }
        })
        
        
        
        
        
    }
    
    func showProgramInfo(_ view: UIView) {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RecommendationCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecommendationCell
        cell.program = data?[indexPath.row]
        cell.isEditable = self.isEditable
        
        if filtered.contains((cell.program?.id)!) == true {
            cell.tickImageView.alpha = 1.0
        } else {
            cell.tickImageView.alpha = 0.0
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isEditable == false {
            (self.parent as! RecommendationsWrapperViewController).performSegue(withIdentifier: "ShowProgramInfo", sender: data?[indexPath.row])
        } else {
            self.checkforSelectedPrograms(tableView)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.checkforSelectedPrograms(tableView)
    }
    
    func checkforSelectedPrograms(_ tableView: UITableView) {
        guard self.isEditable == true else {
            return
        }
        print("\(String(describing: tableView.indexPathsForSelectedRows))")
        if tableView.indexPathsForSelectedRows != nil && tableView.indexPathsForSelectedRows?.count != 0 {
            beginProgramButton.alpha = 1.0
        } else {
            beginProgramButton.alpha = 0.0
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
