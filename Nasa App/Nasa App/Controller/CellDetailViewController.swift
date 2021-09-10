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
    var addFavButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: CellDetailConstants.favHeart), style: .done, target: self, action: #selector(addFavorite))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
        setupNavButtons()
        hideBars(size: UIScreen.main.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        hideBars(size: size)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showBars()
    }
    
    private func addSwiftUIView() {
        let swiftUIView = CellDetailView()
        addSubSwiftUIView(swiftUIView, to: view)
    }
    
    private func setupNavButtons() {
        self.navigationItem.title = CellDetailConstants.navTitle
        self.navigationItem.rightBarButtonItem = self.addFavButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func hideBars(size: CGSize){
        let isLandscape = size.width > size.height
        navigationController?.hidesBarsWhenVerticallyCompact = false
        tabBarController?.tabBar.isHidden = isLandscape ? true : false
        extendedLayoutIncludesOpaqueBars = isLandscape ? true : false
        navigationController?.setNavigationBarHidden(isLandscape ? true : false, animated: true)
        }
    
    private func showBars() {
        navigationController?.hidesBarsWhenVerticallyCompact = true
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    @objc func addFavorite(sender: AnyObject) {
        print(CellDetailConstants.implementMe)
    }
}
