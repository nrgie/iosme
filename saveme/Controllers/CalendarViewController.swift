//
//  CalendarViewController.swift
//  eletmodvaltok
//
//  Created by Gábor Eszenyi on 2017. 05. 10..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet weak var calendarView: CustomCalendar!
   
    var program: Program?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarView.updateFor(program: self.program!)
        self.closeButton.setImage(UIImage(named:"weightclose")?.maskWithColor(color: UIColor(netHex: 0xFAF4E8)), for: UIControlState())
        self.dayLabel.text = "\((program!.currentDay)!). nap"
        NotificationCenter.default.addObserver(self, selector: #selector(dismissCalendar), name: Constants.Notifications.ShowDailyProgramNotification, object: nil)
    }
    
    func dismissCalendar() {
        self.dismiss(nil)
    }
    
    @IBAction func dismiss(_ sender: UIGestureRecognizer?) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension CalendarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.containerView))!{
            return false
        }
        return true
    }
}
