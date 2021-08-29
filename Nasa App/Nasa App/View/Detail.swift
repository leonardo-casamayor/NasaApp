//
//  Detail.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 24/08/2021.
//

import SwiftUI
import AVKit

struct Detail: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        let fontSize = sizeClass == .compact ? smallFont : largeFont
        
        NavigationView {
            ZStack {
                
                Spacer()
                    .background(nasaBlueDetail)
                    .edgesIgnoringSafeArea(.bottom)
                    .edgesIgnoringSafeArea(.horizontal)
                
                GeometryReader { geo in
                    
                    let screenWidth = geo.size.width
                    let screenHeight = geo.size.height
                    let isPortrait = screenWidth < screenHeight
                    let videoHiehgt = isPortrait ? (screenWidth * videoAspectRatio) : screenHeight
                    
                    VStack {
                        
                        ZStack {
                            Image("example")
                                .resizable()
                                .scaledToFit()
                                .background(Color.clear)
                            if isPortrait {
                                DetailGradient(color: nasaBlueDetail)
                            }
                            VStack {
                                if isPortrait {
                                    Spacer()
                                    DetailTitleText(withTextFontSize: fontSize.titleFontSize, width: screenWidth)
                                }
                            }
                            Button{} label: {
                                Label("", systemImage: "play.fill")
                            }
                        }
                        .frame(width: screenWidth, height: videoHiehgt, alignment: .center)
                        
                        if isPortrait {
                            DetailScrollView(withTextFontSize: fontSize.descriptionFontSize, width: screenWidth)
                        }
                        
                    }
                }
                
                //Navigation View Settings
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Close"){}
                    }
                    ToolbarItemGroup{
                        Button{}
                            label: {
                                Label("favorite", systemImage: "heart")
                            }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail()
    }
}
