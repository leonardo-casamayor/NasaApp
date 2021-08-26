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
                    .background(nasaBlue)
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
                                gradient(color: nasaBlue)
                            }
                            VStack {
                                if isPortrait {
                                    Spacer()
                                    titleText(screenWidth, withTextFontSize: fontSize.titleFontSize)
                                }
                            }
                            Button{} label: {
                                Label("", systemImage: "play.fill")
                            }
                        }
                        .frame(width: screenWidth, height: videoHiehgt, alignment: .center)
                        
                        if isPortrait {
                            scrollView(screenWidth, withTextFontSize: fontSize.descriptionFontSize)
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

private func scrollView(_ width: CGFloat, withTextFontSize: CGFloat) -> some View {
    return ScrollView {
        Text(mock)
            .font(.system(size: withTextFontSize))
            .fontWeight(.semibold)
            .padding(.top)
            .frame(width: width * 0.9)
            .foregroundColor(.white)
        
    }
}
private func titleText(_ width: CGFloat, withTextFontSize: CGFloat) -> some View {
    return Text("Title / Date")
        .foregroundColor(.white)
        .font(.system(size: withTextFontSize))
        .fontWeight(.bold)
        .frame(maxWidth: width * 0.93, alignment: .leading)
}

private func gradient(color: Color) -> some View {
    return Rectangle()
        .fill(
            LinearGradient(gradient: Gradient(colors: [.clear, color]), startPoint: .top, endPoint: .bottom))
        .padding(.top)
}
