//
//  FavoriteViewController.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 03/09/2021.
//

import UIKit

class FavoriteViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    private let collectionView = UICollectionView(frame: .zero,collectionViewLayout: CollectionViewHelper.generateLayout(size: CollectionViewConstants.LayoutSize(columns: 2, height: 1/3)))
    
    override func viewDidLoad() {
        setupCollectionViewController()
        collectionView.delegate = self
    }
    
    private func setupCollectionViewController() {
        view.addSubview(collectionView)
        view.backgroundColor = GeneralConstants.nasaBlue
        configureNavigationBar(largeTitleColor: .black, backgoundColor: .white, tintColor: .white, title: "Favorites", preferredLargeTitle: true)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        CollectionViewHelper.setupCollectionView(self, collectionView: collectionView, traitCollection: traitCollection, identifier: CollectionCell.Favoriteidentifier)
        collectionViewConstraints()
    }
    
    private func collectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    }
    
    private func sendToCellDetails() {
        // setup here any data we will pass to the next viewcontroller
        guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CellDetailViewController") as? CellDetailViewController else { return }
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

//MARK: CollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.Favoriteidentifier, for: indexPath)
        return cell
    }
    
}

//MARK: Compositional Layout
extension FavoriteViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        CollectionViewHelper.traitCollectionDidChange(collectionView: collectionView, traitCollection: traitCollection)
    }
}

// MARK: Navigation Controller Configuration
extension FavoriteViewController {
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendToCellDetails()
    }
}
