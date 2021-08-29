//
//  DetailTitleText.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 29/08/2021.
//

import SwiftUI

struct DetailTitleText: View {
    
    var withTextFontSize: CGFloat
    var width: CGFloat
    
    var body: some View {
        Text("Title / Date")
            .foregroundColor(.white)
            .font(.system(size: withTextFontSize))
            .fontWeight(.bold)
            .frame(maxWidth: width * 0.93, alignment: .leading)
    }
}
