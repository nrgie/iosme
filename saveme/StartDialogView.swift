//
//  SettingAvatarView.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AudioToolbox

class StartDialogView: UIView, CountdownTimerDelegate {

    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var counterView: UIStackView!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    var countdownTimerDidStart = false
    
    lazy var countdownTimer: CountdownTimer = {
        let countdownTimer = CountdownTimer()
        return countdownTimer
    }()
    
    
    // Test, for dev
    let selectedSecs:Int = 30
    
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame:CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0, weight: UIFontWeightLight)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Done!"
        
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup() {
        countdownTimer.delegate = self as! CountdownTimerDelegate
        countdownTimer.setTimer(hours: 0, minutes: 0, seconds: selectedSecs)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: selectedSecs)
        
        addSubview(messageLabel)
        
        var constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(constraintCenter)
        constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(constraintCenter)
        
        messageLabel.isHidden = true
        counterView.isHidden = false
        
        messageLabel.isHidden = true
        counterView.isHidden = false
        
        stopBtn.isEnabled = true
        stopBtn.alpha = 1.0
        
        if !countdownTimerDidStart{
            countdownTimer.start()
            progressBar.start()
            countdownTimerDidStart = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = Bundle.main.loadNibNamed("StartDialog", owner: self, options: nil)?.last as! UIView
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func countdownTime(time: (hours: String, minutes: String, seconds: String)) {
        hours.text = time.hours
        minutes.text = time.minutes
        seconds.text = time.seconds
    }
    
    
    func countdownTimerDone() {
        
        counterView.isHidden = true
        messageLabel.isHidden = false
        seconds.text = String(selectedSecs)
        countdownTimerDidStart = false
        stopBtn.isEnabled = false
        //stopBtn.alpha = 0.5
        startBtn.setTitle("START",for: .normal)
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        NotificationCenter.default.post(name: Constants.Notifications.CloseDialog, object: nil, userInfo: nil)
        
        AppDelegate.shared.Signal(type: AppDelegate.shared.signalType)
        
        print("countdownTimerDone")
    }
    
    
    //MARK: - Actions
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Constants.Notifications.CloseDialog, object: nil, userInfo: nil)
        AppDelegate.shared.Signal(type: AppDelegate.shared.signalType)
    }
    
    
    @IBAction func stopTimer(_ sender: UIButton) {
        countdownTimer.stop()
        progressBar.stop()
        countdownTimerDidStart = false
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        startBtn.setTitle("START",for: .normal)
        
        NotificationCenter.default.post(name: Constants.Notifications.CloseDialog, object: nil, userInfo: nil)
        
    }
    
}
