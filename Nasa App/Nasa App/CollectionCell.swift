//
//  CollectionCell.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 30/08/2021.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    static let identifier = "CollectionCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "I'm a test label"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021-07-16"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.5)
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "NASALaunchScreen")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(transparentView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
        override func layoutSubviews() {
            super.layoutSubviews()
            imageView.frame = contentView.bounds
            titleLabel.frame = contentView.bounds
            transparentView.frame = contentView.bounds
            dateLabel.frame = contentView.bounds
        }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        transparentViewConstraints()
        titleLabelConstraints()
        dateLabelConstraints()
    }
    
    func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: transparentView.centerYAnchor, constant: 8).isActive = true
//        titleLabel.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
//        titleLabel.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
    }
    
    func dateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: transparentView.centerYAnchor, constant: 10).isActive = true
    }
    
    func transparentViewConstraints() {
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        transparentView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        transparentView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
}
