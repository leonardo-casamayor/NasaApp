//
//  DetailViewController.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 26/08/2021.
//

import Foundation
import UIKit
import SwiftUI

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
        
    }
    
    func dismiss() -> Void {
            dismiss(animated: true, completion: nil)
        }
    private func addSwiftUIView() {
        let swiftUIView = Detail(dismissAction: {self.dismiss(animated: true, completion: nil)})
        addSubSwiftUIView(swiftUIView, to: view)
    }
}

extension UIViewController {

    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

