//
//  FavoritesTabViewController.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 17/08/2021.
//

import UIKit

class FavoriteTabViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var favoriteCV: UICollectionView!
    let mockData = FavoritesTabConstants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCV.dataSource = self
        favoriteCV.delegate = self
        configureNavigationBar(largeTitleColor: .black, backgoundColor: .white, tintColor: .white, title: "Favorites", preferredLargeTitle: true)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
}

// MARK: - CollectionView
extension FavoriteTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? FavoritesTabColCell else {
            return UICollectionViewCell()
        }
        cell.configCell(description: mockData.description, date: mockData.date, thumbnail: mockData.url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceSize = UIScreen.main.bounds.size
        let isPortrait = deviceSize.height > deviceSize.width
        let verticalCellSize = CGSize(width: favoriteCV.frame.width * 0.94, height: favoriteCV.frame.height / 3)
        let horizontalCellSize = CGSize(width: favoriteCV.frame.width, height: favoriteCV.frame.height)
        
        return isPortrait ? verticalCellSize : horizontalCellSize
    }
}

extension UIViewController {
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
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title
        
        
    }
}
