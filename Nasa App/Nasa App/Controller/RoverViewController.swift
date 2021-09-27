//
//  RoverViewController.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 16/09/21.
//

import Foundation
import UIKit
import SwiftUI

class RoverViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var roverPhotos: NasaRover? = nil
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos(completed: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCollectionViewController()
    }
    
    private func setupCollectionViewController() {
        view.addSubview(collectionView)
        configureNavigationBar(largeTitleColor: .black, backgroundColor: .white, tintColor: .white, title: "Rover", preferredLargeTitle: true)
        collectionView.backgroundColor = GeneralConstants.nasaBlue
        collectionView.register(RoverCollectionViewCell.self, forCellWithReuseIdentifier: RoverCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func sendToCellDetails() {
        // setup here any data we will pass to the next viewcontroller
        // guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "RoverDetailView") as? RoverDetailView else { return }
        let destinationVC = RoverDetailView()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: CollectionView Setup
extension RoverViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width / 2)-2,
            height: (view.frame.size.width / 2)-2
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverPhotos?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverCollectionViewCell.identifier, for: indexPath) as! RoverCollectionViewCell
        
        cell.roverName.text = roverPhotos?.photos[indexPath.row].rover.name
        cell.dateLabel.text = roverPhotos?.photos[indexPath.row].earthDate
        
        let link = roverPhotos?.photos[indexPath.row].imgSrc
        guard var validLink = link else { return cell }
        // Turning the links from the response into 'https' instead of 'http'
        validLink.insert(contentsOf: "s", at: validLink.index(validLink.startIndex, offsetBy: 4))
        cell.imageView.downloadedFrom(from: validLink)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected", indexPath.row)
        sendToCellDetails()
    }
}



