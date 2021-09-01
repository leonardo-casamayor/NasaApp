//
//  FavoritesTabColCell.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 17/08/2021.
//

import UIKit

class FavoritesTabColCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
        
    override func prepareForReuse() {
        super.prepareForReuse()
        self.descriptionLabel.text = ""
        self.dateLabel.text = ""
    }
}

extension FavoritesTabColCell {
    
    func configCell(description: String, date: String, thumbnail: String) {
        
        self.descriptionLabel.text = description
        self.dateLabel.text = date
        self.thumbnail.setImageFrom(thumbnail)
        
    }
}

