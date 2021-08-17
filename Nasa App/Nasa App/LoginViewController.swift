//
//  ViewController.swift
//  Nasa App
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var fieldsView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var padding1: UIView!
    @IBOutlet weak var padding2: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let blueBackground: [UIView] = [background, fieldsView, buttonsView, containerView, padding1, padding2]

        blueBackground.forEach { view in
            applyBackgroundColor(view)
        }
        
        formatButtons(loginButton)
        formatButtons(registerButton)
    }
    
    func applyBackgroundColor(_ view: UIView) {
        
        view.backgroundColor = UIColor(red:0.02, green:0.24, blue:0.58, alpha:1)
        
    }
    func formatButtons(_ view: UIView) {
        
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red:0.95, green:0.56, blue:0.55, alpha:1)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1).cgColor

    }


}

