//
//  LandingViewController.swift
//  Nasa App
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    
    let nasaBlue = UIColor(red:0.02, green:0.24, blue:0.58, alpha:1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = nasaBlue
        explanationLabel.backgroundColor = nasaBlue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        makeGradient(gradientView)
    }
    
    private func makeGradient(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, nasaBlue.cgColor]
        view.backgroundColor = UIColor.clear
        view.layer.addSublayer(gradientLayer)
    }
    
}

