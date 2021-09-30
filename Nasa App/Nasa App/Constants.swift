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
    static let videoUrl = "https://images-assets.nasa.gov/video/NHQ_2014_1010_TWAN/NHQ_2014_1010_TWAN~mobile.mp4"
    static let duration = "duration"
    static let hoursFormat = "%i:%02i:%02i"
    static let minutesFormat = "%02i:%02i"
    static let bigIpad: CGFloat = 1200.00
    static let mediumIpad: CGFloat = 1000.00
    static let verticalSmallPad: CGFloat = 750.00
    static let bigIhpone: CGFloat = 897.00
    static let distanceToPlay: CGFloat = 0.1
    static let bigHeightMod: CGFloat = 0.1
    static let smallHeightMod: CGFloat = 0.14
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


struct CellDetailConstants {
    //MARK: - Colors
    static let topGradientColor = UIColor(red: 0.04, green: 0.44, blue: 0.78, alpha: 0.07)
    static let bottomGradientColor = UIColor(red: 0.02, green: 0.24, blue: 0.58, alpha: 1)
    static let backgroundColor = CGColor(red: 0.02, green: 0.24, blue: 0.58, alpha: 1)
    
    //MARK: - Images
    static let placeHolderImage = #imageLiteral(resourceName: "PlaceholderCellDetails")
    static let playButton = #imageLiteral(resourceName: "PlayButton")
    static let crossMark = "xmark"
    static let favHeart = "suit.heart.fill"
    
    //MARK: - Size Modifiers
    static let rectPaddingMod: CGFloat = 0.1
    static let rectRadius: CGFloat = 4
    static let imageHeightModifier: CGFloat = 0.39
    static let imageHeightModifierPad: CGFloat = 0.425
    static let playHeightMod: CGFloat = 0.15
    static let playWidthMod: CGFloat = 0.25
    static let playPadMod: CGFloat = 0.12
    static let widthConstraint: CGFloat = 0.93
    static let textTopPadding: CGFloat = 0.12
    
    //MARK: - Fonts
    static let fontCompactTitle: UIFont = UIFont (name: "HelveticaNeue-Medium", size: 20)!
    static let fontCompactText: UIFont = UIFont (name: "HelveticaNeue-Medium", size: 17)!
    static let fontRegularTitle: UIFont = UIFont (name: "HelveticaNeue-Medium", size: 26)!
    static let fontRegularText: UIFont = UIFont (name: "HelveticaNeue-Medium", size: 23)!
    
    
    //MARK: - Strings
    static let storyboardID = "Main"
    static let videoPlayerID = "VideoPlayer"
    static let navTitle = "VideoTitleGoesHere"
    static let title = "Title, and date goes here"
    static let implementMe = "Implement Favorite button function here"
    static let mockText = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
}

struct DetailPlaceholderInfo {
    static let textContent = "Shi Huan / 2021-07-16 \nVenus, named for the Roman goddess of love, and Mars, the war god's namesake, come together by moonlight in this serene skyview, recorded on July 11 from Lualaba province, Democratic Republic of Congo, planet Earth. Taken in the western twilight sky shortly after sunset the exposure also records earthshine illuminating the otherwise dark surface of the young crescent Moon. Of course the Moon has moved on. Venus still shines in the west though as the evening star, third brightest object in Earth's sky, after the Sun and the Moon itself. Seen here above a brilliant Venus, Mars moved even closer to the brighter planet and by July 13 could be seen only about a Moon's width away. Mars has since slowly wandered away from much brighter Venus in the twilight, but both are sliding toward bright star Regulus. Alpha star of the constellation Leo, Regulus lies off the top of this frame and anticipates a visit from Venus and then Mars in twilight skies of the coming days."
    static let videoPlaceholder = "https://images-assets.nasa.gov/video/JPL-20190701-WHATSUf-0001-Whats_Up_July_2019/JPL-20190701-WHATSUf-0001-Whats_Up_July_2019~medium.mp4"
    static let errorVideo = "https://temp.media/video/?height=400&width=500&length=10&text=error"
    static let roverUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=ezs9fJo4LZbTb4mHX9qdcclsfLNmxxsqJ6dAX2e5"
}
