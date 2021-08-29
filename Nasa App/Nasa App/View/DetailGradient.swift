//
//  DetailGradient.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 29/08/2021.
//

import SwiftUI

struct DetailGradient: View {
    
    var color: Color
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(gradient: Gradient(colors: [.clear, color]), startPoint: .top, endPoint: .bottom))
            .padding(.top)
    }
}
