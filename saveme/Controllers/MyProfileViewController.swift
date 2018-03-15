//
//  MyProfileViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 10..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit
import SnapKit
import CHIPageControl

enum ButtonStyle {
    case showTasks
    case dailyTaskNotCompleted // Ok, vettem a napi feladatot
    case dailyTaskCompleted // x. nap teljesítve
}

class MyProfileViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: CHIBasePageControl!
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var nextPageButton: UIButton!
    @IBOutlet var prevPageButton: UIButton!
    @IBOutlet var completeButton: UIButton!
    var programs: [Program]?
    
    var buttonStyle: ButtonStyle? {
        didSet {
            completeButton.titleLabel?.adjustsFontSizeToFitWidth = true
            if buttonStyle == .showTasks {
                completeButton.setImage(nil, for: UIControlState())
                completeButton.setTitle("Kérlek nézd meg a napi programodat", for: UIControlState())
            } else if buttonStyle == .dailyTaskNotCompleted {
                completeButton.setImage(UIImage(named: "checkboxUnchecked"), for: UIControlState())
                completeButton.setTitle("Ok, vettem a napi feladatot", for: UIControlState())
                
            } else if buttonStyle == .dailyTaskCompleted {
                completeButton.setImage(UIImage(named: "checkboxChecked"), for: UIControlState())
                completeButton.setTitle("\((self.programs!.first!.currentDay)!). nap teljesítve", for: UIControlState())
            }
        }
    }
    
    
    var currentPage: Int = 0 {
        didSet {
            if currentPage == cellCount-1 {
                self.nextButton.isEnabled = false
                self.nextPageButton.alpha = 0.0
            } else {
                self.nextButton.isEnabled = true
                self.nextPageButton.alpha = 1.0
            }
            
            if currentPage == 0 {
                self.prevPageButton.alpha = 0.0
            } else {
                self.prevPageButton.alpha = 1.0
            }
        }
    }
    
    var cellCount: Int = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 0
        self.dataUpdated()
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated), name: Constants.Notifications.ProgramUpdatedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showDailyProgram), name: Constants.Notifications.ShowDailyProgramNotification, object: nil)
        
    }
    
    func dataUpdated() {
        var subscribedProgramIds: [String] = [String]()
        DataStore.shared.subscriptions!.forEach { (s: Subscription) in
            subscribedProgramIds.append(s.programId)
            print(s.programId)
            if s.programId == "6" {
                DataStore.shared.runSubscribed = true
            }
        }
        
        self.programs = (DataStore.shared.programs?.filter { subscribedProgramIds.contains($0.id) })!
        cellCount = (self.programs?.count)!
        pageControl.numberOfPages = 1 // cellCount - Paging is turned off
        if let program: Program = self.programs?.first {
            let keyViewed = "\(program.id!)-\(program.currentDay!)-viewed"
            let keyCompleted = "\(program.id!)-\(program.currentDay!)-completed"

            if (UserDefaults.standard.object(forKey: keyViewed) == nil) {
                self.buttonStyle = .showTasks
            } else if (UserDefaults.standard.object(forKey: keyViewed) != nil && UserDefaults.standard.object(forKey: keyCompleted) == nil) {
                self.buttonStyle = .dailyTaskNotCompleted
            } else {
                self.buttonStyle = .dailyTaskCompleted
            }
            
        }
        self.collectionView.reloadData()
    }
    
    func showDailyProgram(notification: Notification) {
        if let dayNumber: NSNumber = notification.object as? NSNumber {
            if dayNumber.intValue > Int((programs?.first!.currentDay)!)!  {
                return
            }
            if let program: Program = self.programs?[currentPage] {
                let key = "\(program.id!)-\(program.currentDay!)-viewed"
                UserDefaults.standard.set("finished", forKey: key)
                UserDefaults.standard.synchronize()
                if self.buttonStyle != .dailyTaskCompleted {
                    self.buttonStyle = .dailyTaskNotCompleted
                }
            }
            let controller: WebController = self.storyboard?.instantiateViewController(withIdentifier: "WebController") as! WebController
            let urlStrings: [String: String] = DataStore.shared.dailyProgramURL(for: dayNumber.stringValue)
            controller.unloadedURL = urlStrings.count
            controller.staticContent = true
            for (programId, url) in urlStrings {
                RestClient.loadPage(url: url,programId: programId, delegate: controller)
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}

extension MyProfileViewController {
    // IBActions
    @IBAction func nextPage(_ sender: UIButton) {
        guard sender.isEnabled == true else {
            return
        }
        if currentPage < cellCount-1 {
            self.collectionView.scrollToItem(at: IndexPath(row: self.currentPage + 1, section: 0), at: .left, animated: true)
        }
    }
    
    @IBAction func prevPage(_ sender: UIButton) {
        if currentPage > 0 {
            self.collectionView.scrollToItem(at: IndexPath(row: self.currentPage - 1, section: 0), at: .left, animated: true)
        }
    }
    
    @IBAction func complete(_ sender: UIButton) {
        if self.buttonStyle == .dailyTaskNotCompleted {
            sender.setImage(UIImage(named: "checkboxChecked"), for: UIControlState())
            RestClient.sendDailySuccess(day: (self.programs?.first?.currentDay)!, accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (success: Bool?) in
                self.buttonStyle = .dailyTaskCompleted
                if let program: Program = self.programs?[self.currentPage] {
                    let keyCompleted = "\(program.id!)-\(program.currentDay!)-completed"
                    UserDefaults.standard.set("finished", forKey: keyCompleted)
                    UserDefaults.standard.synchronize()
                    
                }
                if success == true {
                    RestClient.getPrograms(accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (err: String?, programs: [Program]?) in
                        if programs != nil {
                            DataStore.shared.programs = programs
                            NotificationCenter.default.post(name: Constants.Notifications.ProgramUpdatedNotification, object: nil)
                        }
                    })
                }
            })
        } else if self.buttonStyle == .showTasks {
            if let program: Program = self.programs?[currentPage] {
                let key = "\(program.id!)-\(program.currentDay!)-viewed"
                UserDefaults.standard.set("finished", forKey: key)
                UserDefaults.standard.synchronize()
                self.buttonStyle = .dailyTaskNotCompleted
                
                NotificationCenter.default.post(name: Constants.Notifications.ShowDailyProgramNotification, object: NSNumber(value: Int(program.currentDay)!))
            }
        }
    }
    
    @IBAction func showWeightInput(_ sender: UIButton) {
        if let program: Program = self.programs?.first {
            if (program.weights == nil || (program.weights != nil && !((program.weights.allKeys as? [String])?.contains(program.currentDay))!)) {
                self.performSegue(withIdentifier: "ShowWeightInput", sender: self)
            } else {
                MessageUtils.show(message: "Error.AlreadyEnteredWeight".localized, with: "Error".localized, on: self)
            }
        }
    }
    
    @IBAction func showCalendar(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ShowCalendar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCalendar" {
            if let calendarViewController = segue.destination as? CalendarViewController {
                calendarViewController.program = self.programs?[currentPage]
            }
        } else if segue.identifier == "ShowWeightInput" {
            if let weightInputViewController = segue.destination as? WeightInputViewController {
                weightInputViewController.program = self.programs?[currentPage]
            }
        }
    }
    
}

extension MyProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 //cellCount
    }
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell: ProgressionCellView = (collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProgressionCellView)!
        cell.bind(to: self.programs![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let program = self.programs?.first {
            print("\n\nShow program: \(program.currentDay)")
            NotificationCenter.default.post(name: Constants.Notifications.ShowDailyProgramNotification, object: NSNumber(value: Int(program.currentDay)!))
        }
    }
    
}

extension MyProfileViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let total = scrollView.contentSize.width - scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        let percent = Double(offset / total)
        
        let progress = percent * Double(cellCount - 1)
        currentPage = Int(progress)
        self.pageControl.progress = progress
        
    }
    
}

extension MyProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
}

extension MyProfileViewController: UIScrollViewDelegate {
    
}
