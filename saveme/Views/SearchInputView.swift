//
//  SearchInputView.swift
//

import Foundation
import UIKit

class SearchInputView : UIView, UITextFieldDelegate {
    
    var searchButton: UIButton!
    var inputTextField: UITextField
    var toggled: Bool = false
    var animating: Bool = false
    let inputWidth: CGFloat = 140.0
    
    override init(frame: CGRect) {
        searchButton = UIButton(frame: CGRect(x: frame.size.width - 22.0, y: 0, width: 22.0, height: frame.size.height))
        //searchButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        inputTextField = UITextField(frame: CGRect(x: frame.size.width, y: 0.0, width: 0.0, height: frame.size.height))
        inputTextField.borderStyle = .roundedRect
        inputTextField.backgroundColor = .white
        inputTextField.placeholder = "SearchInput.Placeholder".localized
        //searchButton.setTitle(String.fontAwesomeIcon(name: .search), for: .normal)
        super.init(frame: frame)
        addSubview(searchButton)
        addSubview(inputTextField)
        inputTextField.delegate = self
        searchButton.addTarget(self, action: #selector(toggleSearch), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == nil || textField.text == "" { return true }
        let urlString = "http://eletmodvaltok.com/?s=\(textField.text!)"
        let url: URL? = URL(string: urlString)
        self.endEditing(true)
        self.toggleSearch()
        textField.text = ""
        //UIApplication.shared.openURL(url!)
        return true
    }

    
    func toggleSearch() {
        if animating { return }
        let animDuration = 1.0
        self.animating = true
        if ( self.toggled ) {
            UIView.animate(withDuration: animDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations:  { [weak self] in
                self?.searchButton.frame.origin.x += ((self?.inputWidth)! + 10.0)
                self?.inputTextField.frame.size.width = 0
                self?.inputTextField.frame.origin.x += (self?.inputWidth)!
                self?.endEditing(true)
            }, completion: { [weak self] (success: Bool) in
                self?.animating = false
            })
        } else {
            UIView.animate(withDuration: animDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations:  { [weak self] in
                self?.searchButton.frame.origin.x -= ((self?.inputWidth)! + 10.0)
                self?.inputTextField.frame.origin.x -= (self?.inputWidth)!
                self?.inputTextField.frame.size.width = (self?.inputWidth)!
                self?.inputTextField.becomeFirstResponder()
            }, completion: { [weak self] (success: Bool) in
                self?.animating = false
            })
        }
        self.toggled = !self.toggled
        
    }
}
