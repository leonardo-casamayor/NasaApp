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
        self.thumbnail.image = #imageLiteral(resourceName: "Loading")
        self.descriptionLabel.text = ""
        self.dateLabel.text = ""
    }
    
}

extension FavoritesTabColCell {
    
    func configCell(description: String, date: String, thumbnail: String) {
        
        self.descriptionLabel.text = description
        self.descriptionLabel.textColor = UIColor.white
        self.dateLabel.text = date
        self.dateLabel.textColor = UIColor.white
        DispatchQueue.global().async {
            if let url = URL(string: thumbnail) {
                do {
                    let imgData = try Data(contentsOf: url)
                    if let image = UIImage(data: imgData) {
                        DispatchQueue.main.async {
                            self.thumbnail.image = image
                            self.thumbnail.layer.cornerRadius = 15
                            self.thumbnail.clipsToBounds = true
                        }
                        
                    }
                } catch {
                    self.thumbnail.image = #imageLiteral(resourceName: "Loading")
                }
            }
        }
        
    }
}

