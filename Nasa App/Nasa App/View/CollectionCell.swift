//
//  CollectionCell.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 30/08/2021.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    static let PopularIdentifier = "PopularCell"
    static let Favoriteidentifier = "FavoriteCell"
    private var views:[UIView] = []
    
    //MARK: Views
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.5)
        return view
    }()
    
    var imageView: MyImageView = {
        let imageView = MyImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "popular-example")
        return imageView
    }()
    //MARK: Initialization and setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.dateLabel.text = ""
        self.imageView.image = nil
    }
    
    private func setupCell() {
        views = [imageView, transparentView, titleLabel, dateLabel]
        views.forEach { contentView.addSubview($0) }
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        setupConstraints()
    }
    private func setupSubviews() {
        views.forEach { setViewFrameToBounds(view: $0) }
    }
    
    private func setViewFrameToBounds(view: UIView) {
        view.frame = contentView.bounds
    }
    func configureCellWith(data: [NasaData]) {
        self.dateLabel.text = DateFormat.formatDate(dateString: data[0].dateCreated)
        self.titleLabel.text = data[0].title.lowercased().trunc(length: 30).capitalized
        self.titleLabel.font = (data[0].title.count > 30) ? UIFont.systemFont(ofSize: 22, weight: .semibold) : UIFont.systemFont(ofSize: 28, weight: .semibold)
    }
}

//MARK: Constraints
extension CollectionCell {
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        transparentViewConstraints()
        titleLabelConstraints()
        dateLabelConstraints()
    }
    
    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: transparentView.centerYAnchor, constant: 8).isActive = true
    }
    
    private func dateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: transparentView.leftAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: transparentView.centerYAnchor, constant: 10).isActive = true
    }
    
    private func transparentViewConstraints() {
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        transparentView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        transparentView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3).isActive = true
    }
}
