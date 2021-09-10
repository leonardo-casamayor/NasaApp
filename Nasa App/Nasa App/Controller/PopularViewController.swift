//
//  CollectionViewController.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 30/08/2021.
//

import UIKit

class PopularViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    private let collectionView = UICollectionView(frame: .zero,collectionViewLayout: CollectionViewHelper.generateLayout(size: CollectionViewConstants.LayoutSize(columns: 2, height: 1/3)))
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        setupCollectionViewController()
    }
    
    private func setupCollectionViewController() {
        view.addSubview(collectionView)
        view.backgroundColor = GeneralConstants.nasaBlue
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        CollectionViewHelper.setupCollectionView(self, collectionView: collectionView, traitCollection: traitCollection, identifier: CollectionCell.PopularIdentifier)
        collectionViewConstraints()
    }
    
    private func setupSearchBar() {
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    private func collectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    }
}

//MARK: CollectionViewDataSource
extension PopularViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.PopularIdentifier, for: indexPath)
        return cell
    }
    
}

//MARK: Compositional Layout
extension PopularViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        CollectionViewHelper.traitCollectionDidChange(collectionView: collectionView, traitCollection: traitCollection)
    }
}

//MARK: Collection View Delegate
extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PopularDetail", sender: nil)
    }
}
