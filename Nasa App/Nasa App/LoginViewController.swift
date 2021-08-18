//
//  ViewController.swift
//  Nasa App
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor(self.view)
        setBackgroundColor(buttonsView)
        formatButtons(loginButton)
        formatButtons(registerButton)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupTextFields()

        
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.endEditing(true)
//        return true
//    }
    
    func setupTextFields() {
            let toolbar = UIToolbar()
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                             target: self, action: #selector(doneButtonTapped))
            
            toolbar.setItems([flexSpace, doneButton], animated: true)
            toolbar.sizeToFit()
            
            userField.inputAccessoryView = toolbar
            passwordField.inputAccessoryView = toolbar
        }
        
        @objc func doneButtonTapped() {
            view.endEditing(true)
        }
    
    func setBackgroundColor (_ view: UIView) {
        view.backgroundColor = UIColor(red:0.02, green:0.24, blue:0.58, alpha:1)
    }
    
    func formatButtons(_ view: UIView) {
        
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red:0.95, green:0.56, blue:0.55, alpha:1)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1).cgColor

    }
    
    @IBAction func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @IBAction func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

