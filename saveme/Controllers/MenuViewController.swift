//
//  MenuViewController.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit
import KYDrawerController

class MenuViewController : UITableViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    var loggedInMenuItems = [MenuItem(placeholder: true),  MenuItem(titleKey:"Menu.MainPage", urlString: "/"),  MenuItem(titleKey:"Menu.Profile", type: Constants.MenuItemType.ShowProfile), MenuItem(titleKey:"Menu.MyDailyProgram", type: Constants.MenuItemType.ShowMyDailyProgram), MenuItem(titleKey:"Menu.Programs", type: Constants.MenuItemType.ShowPrograms), MenuItem(titleKey:"Menu.Run", urlString: "/futas", type: Constants.MenuItemType.ShowRun), MenuItem(titleKey:"Menu.Calculators", urlString: "/kalkulatorok"),MenuItem(titleKey:"Menu.Mentors", urlString: "/szakertok"), MenuItem(titleKey:"Menu.QA", type: Constants.MenuItemType.ShowFaq), MenuItem(titleKey:"Menu.Favourites", type: Constants.MenuItemType.ShowFavourites),MenuItem(titleKey:"Menu.ProfileEdit", type: Constants.MenuItemType.ShowProfileEdit), MenuItem(titleKey:"Menu.Logout", type: Constants.MenuItemType.Logout), MenuItem(titleKey:"Menu.FacebookGroup", type: Constants.MenuItemType.ShowFacebookGroup)]
    var loggedOutMenuItems = [MenuItem(placeholder: true),MenuItem(titleKey:"Menu.Login", type: Constants.MenuItemType.ShowLogin), MenuItem(titleKey:"Menu.Registration", type: Constants.MenuItemType.ShowRegistration), MenuItem(titleKey:"Menu.MainPage", urlString: "/"), MenuItem(titleKey:"Menu.WhatIsThat", urlString: "/programok"),MenuItem(titleKey:"Menu.DailyPrograms", type: Constants.MenuItemType.ShowLogin), MenuItem(titleKey:"Menu.Calculators", urlString: "/kalkulatorok"), MenuItem(titleKey:"Menu.Mentors", urlString: "/szakertok"),MenuItem(titleKey:"Menu.Run", urlString: "/2017/06/15/fuss-velunk"), MenuItem(titleKey:"Menu.QA", urlString: "/kerdezek"), MenuItem(titleKey:"Menu.FacebookGroup", type: Constants.MenuItemType.ShowFacebookGroup)]
    

    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.closeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
        //self.closeButton.setTitle(String.fontAwesomeIcon(name: .close), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(userRegistration), name: Constants.Notifications.UserRegistrationNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: Constants.Notifications.UserLoggedInNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedOut), name: Constants.Notifications.UserLoggedOutNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showLogin), name: Constants.Notifications.ShowLoginNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showRegistration), name: Constants.Notifications.ShowRegistrationNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showInfoAbout ), name: Constants.Notifications.ShowInfoNotification, object: nil)
    }
    
    
    // Mark: - UITableView methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuItemCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.MenuItemCell) as! MenuItemCell
        let item: MenuItem = DataStore.shared.userData == nil ? self.loggedOutMenuItems[indexPath.item] : self.loggedInMenuItems[indexPath.item]
        if item.placeholder {
            cell.itemTitleLabel.text = ""
        } else {
            cell.itemTitleLabel.text = item.titleKey?.localized
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item: MenuItem = DataStore.shared.userData == nil ? self.loggedOutMenuItems[indexPath.item] : self.loggedInMenuItems[indexPath.item]
        //self.userLabel.text  = DataStore.shared.userData == nil ? "Életmódváltók" : DataStore.shared.userData?.firstName
        return item.placeholder ? 22.0 : 44.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataStore.shared.userData == nil {
            return self.loggedOutMenuItems.count
        } else {
            return self.loggedInMenuItems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: MenuItem = DataStore.shared.userData == nil ? self.loggedOutMenuItems[indexPath.item] : self.loggedInMenuItems[indexPath.item]
        if item.placeholder { return }
        self.showContentFor(item: item)
        self.closeMenu(self)
    }
    
    private func showContentFor(item: MenuItem) {
        if let drawerController = self.parent as? KYDrawerController {
            if let navController = drawerController.mainViewController as? UINavigationController {
                if item.type == Constants.MenuItemType.ShowWebContent {
                    let rootController: WebController? = self.storyboard?.instantiateViewController(withIdentifier: "WebController") as? WebController
                    rootController?.rootURL = URL(string: Constants.EndPoints.WPApi + item.urlString!)
                    navController.setViewControllers([rootController!], animated: true)
                    rootController?.addMenuNavigationItem()
                    rootController?.addSearchNavigationItem()
                } else if item.type == Constants.MenuItemType.ShowProfile {
                    
                    if (DataStore.shared.subscriptions?.count)! > 0 {
                        
                        var running: Bool = false
                        DataStore.shared.subscriptions!.forEach { (s: Subscription) in
                            if s.programId == "6" {
                                running = true
                            }
                        }
                        
                        if running && (DataStore.shared.subscriptions?.count)! > 1 {
                            
                            let rootController = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController") as? MyProfileViewController
                            navController.setViewControllers([rootController!], animated: true)
                            rootController?.addMenuNavigationItem()
                            rootController?.addSearchNavigationItem()
                            
                        } else {
                           
                            let rootController: DecideViewController? = self.storyboard?.instantiateViewController(withIdentifier: "DecideViewController") as? DecideViewController
                            navController.setViewControllers([rootController!], animated: true)
                            rootController?.addMenuNavigationItem()
                            rootController?.addSearchNavigationItem()
                            
                        }
                        
                    } else {
                        
                        let rootController: DecideViewController? = self.storyboard?.instantiateViewController(withIdentifier: "DecideViewController") as? DecideViewController
                        navController.setViewControllers([rootController!], animated: true)
                        
                        rootController?.addMenuNavigationItem()
                        rootController?.addSearchNavigationItem()
                        
                    }
                    
                } else if item.type == Constants.MenuItemType.ShowLogin {
                    /*
                    let rootController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                    navController.setViewControllers([rootController!], animated: true)
                    rootController?.addMenuNavigationItem()
                    rootController?.addSearchNavigationItem()
                    */
                } else if item.type == Constants.MenuItemType.ShowRegistration {
                    let rootController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController
                    navController.setViewControllers([rootController!], animated: true)
                    rootController?.addMenuNavigationItem()
                    rootController?.addSearchNavigationItem()
                } else if item.type == Constants.MenuItemType.ShowFacebookGroup {
                    UIApplication.shared.openURL(URL(string: "https://www.facebook.com/groups/267266203706084/")!)
                } else if item.type == Constants.MenuItemType.Logout {
                    DataStore.shared.clearData()
                    NotificationCenter.default.post(name: Constants.Notifications.UserLoggedOutNotification, object: nil, userInfo: nil)
                } else if item.type == Constants.MenuItemType.ShowFaq {
                    UIApplication.shared.openURL(URL(string: "http://eletmodvaltok.com/kerdezek/")!)
                } else if item.type == Constants.MenuItemType.ShowRun {
                    
                    var runSubscribed: Int = 0
                    DataStore.shared.subscriptions!.forEach { (s: Subscription) in
                        print(s.programId)
                        if s.programId == "6" {
                            runSubscribed = 1
                        }
                    }
                    
                    /*
                    if runSubscribed == 0 {
                        
                        let rootController: RunViewController? = self.storyboard?.instantiateViewController(withIdentifier: "RunViewController") as? RunViewController
                    
                        navController.setViewControllers([rootController!], animated: true)
                        rootController?.addMenuNavigationItem()
                        rootController?.addSearchNavigationItem()
                        
                    } else {
                        
                        let rootController: RunDaysViewController? = self.storyboard?.instantiateViewController(withIdentifier: "RunDaysViewController") as? RunDaysViewController
                        
                        navController.setViewControllers([rootController!], animated: true)
                        rootController?.addMenuNavigationItem()
                        rootController?.addSearchNavigationItem()
                        
                        //UIApplication.shared.openURL(URL(string: "http://eletmodvaltok.com/futas/")!)
                    }
                    */
                    
                } else if item.type == Constants.MenuItemType.ShowProfileEdit {
                    let rootController = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? RegistrationViewController
                    navController.setViewControllers([rootController!], animated: true)
                    rootController?.addMenuNavigationItem()
                    rootController?.addSearchNavigationItem()
                } else if item.type == Constants.MenuItemType.ShowPrograms {
                    if (DataStore.shared.subscriptions?.count)! > 0 {
                        let rootController = self.storyboard?.instantiateViewController(withIdentifier: "RecommendationsWrapperViewController") as? RecommendationsWrapperViewController
                        rootController?.isEditable = false
                        rootController?.titleText = "Programs.Title".localized
                        navController.setViewControllers([rootController!], animated: true)
                        rootController?.addMenuNavigationItem()
                        rootController?.addSearchNavigationItem()
                    } else {
		      
                        let rootController: DecideViewController? = self.storyboard?.instantiateViewController(withIdentifier: "DecideViewController") as? DecideViewController
                        navController.setViewControllers([rootController!], animated: true)
                        rootController?.addMenuNavigationItem()
                        rootController?.addSearchNavigationItem()
                      
                    }
                } else if item.type == Constants.MenuItemType.ShowMyDailyProgram {
                    if let dayNumber = DataStore.shared.programs!.first?.currentDay {
                        let controller: WebController = self.storyboard?.instantiateViewController(withIdentifier: "WebController") as! WebController
                        let urlStrings: [String: String] = DataStore.shared.dailyProgramURL(for: dayNumber)
                        controller.unloadedURL = urlStrings.count
                        controller.staticContent = false
                        for (programId, url) in urlStrings {
                            RestClient.loadPage(url: url,programId: programId, delegate: controller)
                            let key = "\(programId)-\(dayNumber)-viewed"
                            UserDefaults.standard.set("finished", forKey: key)
                            UserDefaults.standard.synchronize()
                        }
                        navController.setViewControllers([controller], animated: true)
                    }
                } else if item.type == Constants.MenuItemType.ShowFavourites {
                    if ((DataStore.shared.programs!.first?.currentDay) != nil) {
                        let controller: WebController = self.storyboard?.instantiateViewController(withIdentifier: "WebController") as! WebController
                        let favourites = DataStore.shared.favourites
                        navController.setViewControllers([controller], animated: true)
                        controller.staticContent = false
                        controller.loadFavourites(favourites ?? [])
                    }
                }
                
            }
        }
    }
    
    // Mark: - Close menu
    
    @IBAction func closeMenu(_ sender: Any) {
        if let drawerController = self.parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
        }
    }
    
    // Mark: - Authentication callbacks
    
    func userRegistration() {
        self.tableView.reloadData()
    }
    
    func userLoggedIn (){
        self.tableView.reloadData()
        showContentFor(item: self.loggedInMenuItems[2])
    }
    
    func userLoggedOut (){
        self.tableView.reloadData()
        showContentFor(item: self.loggedInMenuItems[1])
    }
    
    func showLogin(){
        showContentFor(item: self.loggedOutMenuItems[1])
    }
    
    func showRegistration (){
        showContentFor(item: self.loggedOutMenuItems[2])
    }
    
    func showInfoAbout() {
        showContentFor(item: self.loggedOutMenuItems[2])
    }
}
