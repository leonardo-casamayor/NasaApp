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
                    .frame(height: 200)
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [ NASAColors.NASAGradientStop, NASAColors.NASAPrimary]), startPoint: .top, endPoint: .bottom))
                    .padding(.vertical, -12.0)
                VStack() {
                    Text(PlaceholderInfo.textContent)
                        .foregroundColor(NASAColors.NASAPrimaryText)
                        .padding([.leading, .bottom, .trailing], 10.0)
                }
                .padding(.top, -15.0)
            }
        }
        .background(NASAColors.NASAPrimary)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
