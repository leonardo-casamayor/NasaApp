//
//  DetailScrollView.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 29/08/2021.
//

import SwiftUI

struct DetailScrollView: View {
    
    var withTextFontSize: CGFloat
    var width: CGFloat
    
    var body: some View {
        ScrollView {
            Text(DetailConstants.mock)
                .font(.system(size: withTextFontSize))
                .fontWeight(.semibold)
//                .padding(.top)
                .frame(width: width * 0.9)
                .foregroundColor(.white)
        }
        .padding(.top, 25)
    }
}
