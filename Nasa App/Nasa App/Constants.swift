//
//  Constants.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 23/08/2021.
//

import UIKit

struct GeneralConstants {
    static let nasaBlue = UIColor(red:0.02, green:0.24, blue:0.58, alpha:1)
}

struct LoginConstants {
    static let buttonColor = UIColor(red:0.95, green:0.56, blue:0.55, alpha:1)
    static let buttonBorderColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1)
}
    
struct VideoPlayerConstants {
    static let videoUrl = "https://s3.eu-west-2.amazonaws.com/gymstar-app/7A77786B4870594D7165625046614E74/post_videos/postVideo1582781434.005436.mp4"
}

struct FavoritesTabConstants {
    static let url = "https://apod.nasa.gov/apod/image/2108/Abell3827Lens_Hubble_960.jpg"
    static let description = "NASA"
    static let date = "2018-05-14T00:00:00Z"
}

struct CollectionViewConstants {
    struct LayoutSize {
        let columns: Int
        let height: CGFloat
    }
}
extension UIImage {
    static let muted: UIImage? = UIImage(systemName: "volume.slash.fill")
    static let unmuted: UIImage? = UIImage(systemName: "volume.fill")
    static let play: UIImage? = UIImage(systemName: "play.circle.fill")
    static let pause: UIImage? = UIImage(systemName: "pause.circle.fill")
    static let replay: UIImage? = UIImage(systemName: "arrow.uturn.left")
}
