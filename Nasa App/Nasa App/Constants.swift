//
//  Constants.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 23/08/2021.
//

import UIKit
import SwiftUI

struct GeneralConstants {
    static let nasaBlue = UIColor(red:0.02, green:0.24, blue:0.58, alpha:1)
}

struct LoginConstants {
    static let buttonColor = UIColor(red:0.95, green:0.56, blue:0.55, alpha:1)
    static let buttonBorderColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1)
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
struct DetailConstants {
    struct FontSize {
        let titleFontSize: CGFloat
        let descriptionFontSize: CGFloat
}
static let smallFont = FontSize(titleFontSize: 20, descriptionFontSize: 17)
static let largeFont = FontSize(titleFontSize: 26, descriptionFontSize: 23)

static let nasaBlueDetail = Color(red:0.02, green:0.24, blue:0.58)
static let videoAspectRatio: CGFloat = 3/4

static let mock = "Venus, named for the Roman goddess of love, and Mars, the war god's namesake, come together by moonlight in this serene skyview, recorded on July 11 from Lualaba province, Democratic Republic of Congo, planet Earth. Taken in the western twilight sky shortly after sunset the exposure also records earthshine illuminating the otherwise dark surface of the young crescent Moon. Of course the Moon has moved on. Venus still shines in the west though as the evening star, third brightest object in Earth's sky, after the Sun and the Moon itself. Seen here above a brilliant Venus, Mars moved even closer to the brighter planet and by July 13 could be seen only about a Moon's width away. Mars has since slowly wandered away from much brighter Venus in the twilight, but both are sliding toward bright star Regulus. Alpha star of the constellation Leo, Regulus lies off the top of this frame and anticipates a visit from Venus and then Mars in twilight skies of the coming days. Venus, named for the Roman goddess of love, and Mars, the war god's namesake, come together by moonlight in this serene skyview, recorded on July 11 from Lualaba province, Democratic Republic of Congo, planet Earth. Taken in the western twilight sky shortly after sunset the exposure also records earthshine illuminating the otherwise dark surface of the young crescent Moon. Of course the Moon has moved on. Venus still shines in the west though as the evening star, third brightest object in Earth's sky, after the Sun and the Moon itself. Seen here above a brilliant Venus, Mars moved even closer to the brighter planet and by July 13 could be seen only about a Moon's width away. Mars has since slowly wandered away from much brighter Venus in the twilight, but both are sliding toward bright star Regulus. Alpha star of the constellation Leo, Regulus lies off the top of this frame and anticipates a visit from Venus and then Mars in twilight skies of the coming days."

}
