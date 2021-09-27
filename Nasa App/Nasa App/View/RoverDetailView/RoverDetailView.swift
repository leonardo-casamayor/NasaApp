//
//  RoverDetailView.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 24/09/21.
//

import UIKit
import SwiftUI

class RoverDetailView: UIViewController {
    private var views:[UIView] = []
    var receivedData: Photo? = nil
    
    //MARK: Views
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let transparentView: UIView = {
        let transparentView = UIView()
        transparentView.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.5)
        return transparentView
    }()
    
    var cameraName: UILabel! = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    var dateLabel: UILabel! = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    var roverStatus: UILabel! = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    //MARK: Initialization and setup
    override func loadView() {
        view = UIView()
        guard let validData = receivedData else { return }
        configureNavigationBar(largeTitleColor: .black, backgroundColor: .white, tintColor: .white, title: validData.rover.name, preferredLargeTitle: true)
        setData(from: validData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        views = [imageView, transparentView, dateLabel, cameraName, roverStatus]
        views.forEach { view.addSubview($0) }
        setupConstraints()
    }
}


extension RoverDetailView {
    private func setData(from photo: Photo) {
        let imageURL = RoverViewController().validURL(urlString: photo.imgSrc)
        imageView.downloadedFrom(from: imageURL)
        cameraName.text = photo.camera.fullName
        dateLabel.text = photo.earthDate
        roverStatus.text = "status: \(photo.rover.status)"
    }
}

extension RoverDetailView {
    private func setupConstraints() {
        imageViewContraints()
        transparentViewConstraints()
        cameraNameConstraints()
        dateLabelConstraints()
        roverStatusConstraints()
    }
    
    private func imageViewContraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func transparentViewConstraints() {
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        transparentView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        transparentView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func cameraNameConstraints() {
        cameraName.translatesAutoresizingMaskIntoConstraints = false
        cameraName.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 9).isActive = true
        cameraName.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 10).isActive = true
    }
    
    private func dateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: cameraName.topAnchor, constant: 20).isActive = true
    }
    
    
    private func roverStatusConstraints() {
        roverStatus.translatesAutoresizingMaskIntoConstraints = false
        roverStatus.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
        roverStatus.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 15).isActive = true
    }
}
