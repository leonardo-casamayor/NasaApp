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
        setScrollDirectionOnLoad()
        
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setScrollDirectionOnRotation()
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
        let deviceOrientation = UIDevice.current.orientation.isPortrait
        let verticalCellSize = CGSize(width: favoriteCV.frame.width * 0.94, height: favoriteCV.frame.height / 3)
        let horizontalCellSize = CGSize(width: favoriteCV.frame.width, height: favoriteCV.frame.height)
        return deviceOrientation ? verticalCellSize : horizontalCellSize
    }
}
// MARK: - ViewControllerExtensions
extension FavoriteTabViewController {
    private func setScrollDirectionOnLoad() {
        let size = UIScreen.main.bounds.size
        guard let layout = favoriteCV.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        if size.width < size.height {
            layout.scrollDirection = .vertical
        } else {
            layout.scrollDirection = .horizontal
        }
    }
    private func setScrollDirectionOnRotation() {
        let deviceOrientation = UIDevice.current.orientation.isPortrait
        guard let layout = favoriteCV.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = deviceOrientation ? .vertical :  .horizontal
    }
}
