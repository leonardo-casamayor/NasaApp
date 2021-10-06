//
//  RoverViewController.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 16/09/21.
//

import Foundation
import UIKit

class RoverViewController: UIViewController {
    
    var roverPhotos = [LatestPhoto]() {
        didSet {
            print("Total amount of pics loaded: ", roverPhotos.count)
        }
    }
    
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
        view.backgroundColor = GeneralConstants.nasaBlue
    }
}

// MARK: Action on selected Cell

extension RoverViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
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
}

extension RoverViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected", indexPath.row)
    }
}

extension RoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverCollectionViewCell.identifier, for: indexPath) as! RoverCollectionViewCell
        
        cell.roverName.text = roverPhotos[indexPath.row].rover.name
        cell.dateLabel.text = roverPhotos[indexPath.row].earthDate
        
        let link = roverPhotos[indexPath.row].imgSrc
        guard let link = URL.init(string: link) else { return cell }
        cell.imageView.loadImage(at: link)
        
        return cell
    }
}
