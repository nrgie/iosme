//
//  DatePickerDialog.swift
//  saveme
//
//  Created by Tibor Sulyok on 2018. 03. 19..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

private extension Selector {
    static let buttonTapped = #selector(DatePickerDialog.buttonTapped)
    static let deviceOrientationDidChange = #selector(DatePickerDialog.deviceOrientationDidChange)
}

open class DoctorsDialog: UIView {
    public typealias InputCallback = ( Any? ) -> Void
    
    // MARK: - Constants
    private let kDefaultButtonHeight: CGFloat = 50
    private let kDefaultButtonSpacerHeight: CGFloat = 1
    private let kCornerRadius: CGFloat = 7
    private let kDoneButtonTag: Int     = 1
    
    // MARK: - Views
    private var dialogView: UIView!
    private var slayer: DoctorsDialogView!
    private var titleLabel: UILabel!
    open var datePicker: UIDatePicker!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!
    private var addButton: UIButton!
    
    // MARK: - Variables
    private var defaultDate: Date?
    private var datePickerMode: UIDatePickerMode?
    private var callback: InputCallback?
    var showCancelButton: Bool = false
    var locale: Locale?
    
    private var textColor: UIColor!
    private var buttonColor: UIColor!
    private var font: UIFont!
    
    private var type: String!
    
    // MARK: - Dialog initialization
    public init(textColor: UIColor = UIColor.black,
                buttonColor: UIColor = UIColor.blue,
                type: String = "",
                font: UIFont = .boldSystemFont(ofSize: 15),
                locale: Locale? = nil,
                showCancelButton: Bool = true) {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.textColor = textColor
        self.buttonColor = buttonColor
        self.font = font
        self.type = type
        self.showCancelButton = showCancelButton
        self.locale = locale
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.dialogView = createContainerView()
        
        self.dialogView!.layer.shouldRasterize = true
        self.dialogView!.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.dialogView!.layer.opacity = 0.5
        self.dialogView!.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.addSubview(self.dialogView!)
    }
    
    /// Handle device orientation changes
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        self.frame = UIScreen.main.bounds
        let dialogSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        dialogView.frame = CGRect(x: 0, y: 20, width: dialogSize.width, height: dialogSize.height-20)
    }
    
    /// Create the dialog view, and animate opening the dialog
    open func show(_ title: String,
                   doneButtonTitle: String = "Done",
                   cancelButtonTitle: String = "Cancel",
                   callback: @escaping InputCallback) {
        self.titleLabel.text = title
       
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        if showCancelButton {
            self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }

        self.callback = callback

        self.slayer.setup()
        
        /* Add dialog to main window */
        guard let appDelegate = UIApplication.shared.delegate else { fatalError() }
        guard let window = appDelegate.window else { fatalError() }
        window?.addSubview(self)
        window?.bringSubview(toFront: self)
        window?.endEditing(true)
        
        NotificationCenter.default.addObserver(self,selector: .deviceOrientationDidChange,name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        NotificationCenter.default.addObserver(self,selector: Selector("close"), name: Constants.Notifications.CloseDialog, object: nil)
        
        /* Anim */
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView!.layer.opacity = 1
                self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }
        )
    }
    
    /// Dialog close animation then cleaning and removing the view from the parent
    public func close() {
        let currentTransform = self.dialogView.layer.transform
        
        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + .pi * 270 / 180), 0, 0, 0)
        
        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                let transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.transform = transform
                self.dialogView.layer.opacity = 0
        }) { (_) in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            
            self.removeFromSuperview()
            self.setupView()
        }
    }
    
    /// Creates the container view here: create the dialog, then add the custom content and buttons
    private func createContainerView() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(width: screenSize.width, height: screenSize.height)
        
        // For the black background
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        // This is the dialog's container; we attach the custom content and the buttons to this one
        let container = UIView(frame: CGRect(x: 0, y: 20, width: dialogSize.width, height: dialogSize.height-20))
        
        // First, we style the dialog to match the iOS8 UIAlertView >>>
        let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer)
        gradient.frame = container.bounds
        /*
        gradient.colors = [UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor,
                           UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor,
                           UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor]
        */
        gradient.colors = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor,
                           UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor,
                           UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor]
        
        let cornerRadius = kCornerRadius
        gradient.cornerRadius = cornerRadius
        container.layer.insertSublayer(gradient, at: 0)
        
        container.layer.cornerRadius = cornerRadius
        container.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 0.9).cgColor
        container.layer.borderWidth = 1
        container.layer.shadowRadius = cornerRadius + 5
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowPath = UIBezierPath(roundedRect: container.bounds, cornerRadius: container.layer.cornerRadius).cgPath
        
        // There is a line above the button
        let yPosition = container.bounds.size.height - kDefaultButtonHeight - kDefaultButtonSpacerHeight
        let lineView = UIView(frame: CGRect(x: 0,
                                            y: yPosition,
                                            width: container.bounds.size.width,
                                            height: kDefaultButtonSpacerHeight))
        lineView.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        container.addSubview(lineView)
        
        //Title
        self.titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 280, height: 40))
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = self.textColor
        self.titleLabel.font = self.font.withSize(17)
        container.addSubview(self.titleLabel)
        
        
        self.slayer = configureLayer()
        
        container.addSubview(self.slayer)
        
        // Add the buttons
        addButtonsToView(container: container)
        
        return container
    }
    
    fileprivate func configureLayer() -> DoctorsDialogView {
        let contentFrame = CGRect(x:0, y:40, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-120)
        let result : DoctorsDialogView! = DoctorsDialogView(frame: contentFrame)
        return result
    }
    
    /// Add buttons to container
    private func addButtonsToView(container: UIView) {
        var buttonWidth = container.bounds.size.width / 2
        
        var leftButtonFrame = CGRect(
            x: 0,
            y: container.bounds.size.height - kDefaultButtonHeight,
            width: buttonWidth,
            height: kDefaultButtonHeight
        )
        
        var rightButtonFrame = CGRect(
            x: buttonWidth,
            y: container.bounds.size.height - kDefaultButtonHeight,
            width: buttonWidth,
            height: kDefaultButtonHeight
        )
        
        let addButtonFrame = CGRect( x: container.bounds.size.width - 120, y:0, width: buttonWidth, height: 40)
        
        if showCancelButton == false {
            buttonWidth = container.bounds.size.width
            leftButtonFrame = CGRect()
            rightButtonFrame = CGRect(
                x: 0,
                y: container.bounds.size.height - kDefaultButtonHeight,
                width: buttonWidth,
                height: kDefaultButtonHeight
            )
        }
        let interfaceLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        let isLeftToRightDirection = interfaceLayoutDirection == .leftToRight
        
        if showCancelButton {
            self.cancelButton = UIButton(type: .custom) as UIButton
            self.cancelButton.frame = isLeftToRightDirection ? leftButtonFrame : rightButtonFrame
            self.cancelButton.setTitleColor(self.buttonColor, for: .normal)
            self.cancelButton.setTitleColor(self.buttonColor, for: .highlighted)
            self.cancelButton.titleLabel!.font = self.font.withSize(14)
            self.cancelButton.layer.cornerRadius = kCornerRadius
            self.cancelButton.addTarget(self, action: .buttonTapped, for: .touchUpInside)
            container.addSubview(self.cancelButton)
        }
        self.doneButton = UIButton(type: .custom) as UIButton
        self.doneButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame
        self.doneButton.tag = kDoneButtonTag
        self.doneButton.setTitleColor(self.buttonColor, for: .normal)
        self.doneButton.setTitleColor(self.buttonColor, for: .highlighted)
        self.doneButton.titleLabel!.font = self.font.withSize(14)
        self.doneButton.layer.cornerRadius = kCornerRadius
        self.doneButton.addTarget(self, action: .buttonTapped, for: .touchUpInside)
        container.addSubview(self.doneButton)
        
        self.addButton = UIButton(type: .custom) as UIButton
        self.addButton.frame = addButtonFrame
        self.addButton.tag = 123
        self.addButton.setTitle("ADD", for: .normal)
        self.addButton.setTitleColor(self.buttonColor, for: .normal)
        self.addButton.setTitleColor(self.buttonColor, for: .highlighted)
        self.addButton.titleLabel!.font = self.font.withSize(14)
        self.addButton.layer.cornerRadius = kCornerRadius
        self.addButton.addTarget(self, action: .buttonTapped, for: .touchUpInside)
        container.addSubview(self.addButton)
        
    }
    
    @objc func buttonTapped(sender: UIButton!) {
        if sender.tag == kDoneButtonTag {
            self.callback?(nil)
            close()
        } else if sender.tag == 123 {
            DoctorEditDialog().show("Add new record") {_ in }
        } else {
            self.callback?(nil)
            close()
        }
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
