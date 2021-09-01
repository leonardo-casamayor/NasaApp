//
//  CollectionViewController.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 30/08/2021.
//

import UIKit

class CollectionViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    private let collectionView = UICollectionView(frame: .zero,collectionViewLayout: CollectionViewController.generateLayout(size: LayoutSize(columns: 2, height: 1/3)))
    
    override func viewDidLoad() {
        setupCollectionViewController()
    }
    
    private func setupCollectionViewController() {
        self.view.backgroundColor = nasaBlue
        view.addSubview(collectionView)
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionViewConstraints()
        collectionView.setCollectionViewLayout(CollectionViewController.generateLayout(size: self.setLayoutSize()), animated: false)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
    }
    
    private func collectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    }
}

//MARK: CollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath)
        return cell
    }
    
}

//MARK: Compositional Layout
extension CollectionViewController {
    
    private func setLayoutSize() -> LayoutSize {
        return traitCollection.horizontalSizeClass == .compact ? LayoutSize(columns: 1,height: 2/3) : LayoutSize(columns: 2,height: 1/3)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        collectionView.setCollectionViewLayout(CollectionViewController.generateLayout(size: setLayoutSize()), animated: false)
    }
    
    fileprivate static func generateLayout(size: LayoutSize) -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(size.height)),subitem: item,count: size.columns)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
