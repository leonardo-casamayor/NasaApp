//
//  DetailView.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 07/09/21.
//

import SwiftUI
import AVKit

struct ContentView: View {
    private let videoURL: URL = URL(string: PlaceholderInfo.videoPlaceholder) ?? URL(string: PlaceholderInfo.errorVideo)!
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: geometry.size.height * 0.33)
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [ NASAColors.NASAGradientStop, NASAColors.NASAPrimary]), startPoint: .top, endPoint: .bottom))
                    .frame(width:.infinity, height: geometry.size.height * 0.33)
                    .padding(.top, geometry.size.height * -0.010)
                VStack() {
                    Text(PlaceholderInfo.textContent)
                        .foregroundColor(NASAColors.NASAPrimaryText)
                        .padding([.leading, .bottom, .trailing], geometry.size.width * 0.035)
                }
                .padding(.top, geometry.size.height * -0.32)
            }
        }
        .ignoresSafeArea()
        .background(NASAColors.NASAPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
