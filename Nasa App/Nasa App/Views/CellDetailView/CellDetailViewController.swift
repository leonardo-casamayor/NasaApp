//
//  CellDetailViewController.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 24/08/2021.
//

import Foundation
import UIKit
import SwiftUI

class CellDetailViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: CellDetailView())
        addChild(childView)
        childView.view.frame = viewContainer.bounds
        viewContainer.addSubview(childView.view)
    }
}
