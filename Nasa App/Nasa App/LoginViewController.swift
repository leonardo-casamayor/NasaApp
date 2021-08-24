//
//  LoginViewController.swift
//  Nasa App
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var registerButton: CustomButton!
    @IBOutlet weak var buttonsView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerSetUp()
    }
    
    //MARK: Formatting
    private func viewControllerSetUp() {
        setBackgroundColor(self.view)
        setBackgroundColor(buttonsView)
        formatButtons(loginButton)
        formatButtons(registerButton)
        setupTextFields()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setBackgroundColor (_ view: UIView) {
        view.backgroundColor = nasaBlue
    }
    
    private func formatButtons(_ view: UIView) {
        view.backgroundColor = buttonColor
        view.layer.borderColor = buttonBorderColor.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
    }
    
    //MARK: Keyboard Behaviour
    private func setupTextFields() {
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
    
    @IBAction func keyboardWillShow(notification: NSNotification) {
        if (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue != nil {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= view.frame.height * 0.3
            }
        }
    }
    
    @IBAction func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

