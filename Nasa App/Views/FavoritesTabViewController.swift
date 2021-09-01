//
//  FavoritesTabViewController.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 17/08/2021.
//

import UIKit

class FavoriteTabViewController: UIViewController {
    
    @IBOutlet weak var favoriteCV: UICollectionView!
    
    let mockUrl = "https://images-assets.nasa.gov/video/ARC-20181108-AAV3151-NiSV-Ep06-NASAWeb/ARC-20181108-AAV3151-NiSV-Ep06-NASAWeb~thumb.jpg"
    let mockDescription = "NASA"
    let mockDate = "2018-05-14T00:00:00Z"
    var deviceOrientation = UIDevice.current.orientation.isPortrait

    
    override func viewDidLoad() {
        deviceOrientation = UIDevice.current.orientation.isPortrait
        super.viewDidLoad()
        favoriteCV.delegate = self
        favoriteCV.dataSource = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        deviceOrientation = UIDevice.current.orientation.isPortrait
        guard let layout = favoriteCV.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        layout.scrollDirection = deviceOrientation ? .vertical :  .horizontal
    }
}


extension FavoriteTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? FavoritesTabColCell else {
            return UICollectionViewCell()
        }
        cell.configMockCell(description: mockDescription, date: mockDate, thumbnail: mockUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        deviceOrientation = UIDevice.current.orientation.isPortrait
        
        return deviceOrientation ? CGSize(width: favoriteCV.frame.width, height: favoriteCV.frame.height / 3) : CGSize(width: favoriteCV.frame.width, height: favoriteCV.frame.height)
    }
}
