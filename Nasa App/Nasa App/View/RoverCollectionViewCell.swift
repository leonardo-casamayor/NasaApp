//
//  RoverCollectionViewCell.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 21/09/21.
//

import UIKit

class RoverCollectionViewCell: UICollectionViewCell {
    static let identifier = "RoverCollectionViewCell"
    private var views:[UIView] = []
    let padding: CGFloat = 20

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let roverName: UILabel = {
        let label = UILabel()
        label.text = "Curiosity"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10/04/1991 08:54 CST"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    private let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.5)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        views = [imageView, transparentView, roverName, dateLabel ]
        views.forEach { contentView.addSubview($0) }
        setupConstraints()

        let images = [
            UIImage(named: "popular-example"),
            UIImage(named: "popular-example"),
            UIImage(named: "popular-example"),
            UIImage(named: "popular-example"),
            UIImage(named: "popular-example"),
            UIImage(named: "popular-example")
        ].compactMap({ $0 })
        imageView.image = images.randomElement()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

}

//MARK: Constraints
extension RoverCollectionViewCell {
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        transparentViewConstraints()
        roverNameLabel()
        dateLabelConstraints()
    }
    
    private func roverNameLabel() {
        roverName.translatesAutoresizingMaskIntoConstraints = false
        roverName.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
        roverName.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 10).isActive = true
    }
    
    private func dateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 30).isActive = true
    }
    
    private func transparentViewConstraints() {
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        transparentView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        transparentView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
    }
}
