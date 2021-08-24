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

    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
    }
    
    private func addSwiftUIView() {
        let swiftUIView = CellDetailView()
        addSubSwiftUIView(swiftUIView, to: view)
    }
}


extension UIViewController {

    
    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)

        // Add as a child of the current view controller.
        addChild(hostingController)

        // Add the SwiftUI view to the view controller view hierarchy.
        view.addSubview(hostingController.view)

        // Setup the contraints to update the SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        // Notify the hosting controller that it has been moved to the current view controller.
        hostingController.didMove(toParent: self)
    }
}
