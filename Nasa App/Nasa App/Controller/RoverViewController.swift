//
//  RoverViewController.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 16/09/21.
//

import Foundation
import UIKit

class RoverViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    private let collectionView = UICollectionView(frame: .zero,collectionViewLayout: CollectionViewHelper.generateLayout(size: CollectionViewConstants.LayoutSize(columns: 2, height: 1/3)))
    
    override func viewDidLoad() {
        setupCollectionViewController()
    }
    
    private func setupCollectionViewController() {
        view.addSubview(collectionView)
        view.backgroundColor = GeneralConstants.nasaBlue
        configureNavigationBar(largeTitleColor: .black, backgroundColor: .white, tintColor: .white, title: "Rover", preferredLargeTitle: true)
    }
    
}

// MARK: Navigation Controller Configuration
extension RoverViewController {
    func configureNavigationBar(largeTitleColor: UIColor, backgroundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgroundColor
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
    }
    
}
