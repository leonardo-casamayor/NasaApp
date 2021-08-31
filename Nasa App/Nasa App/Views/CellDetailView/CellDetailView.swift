//
//  CellDetailView.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 19/08/2021.
//

import SwiftUI
import AVKit
let constants = CellDetailConstants()

struct CellDetailView: View {

    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            let isPortrait = screenHeight > screenWidth
            
            if isPortrait {
                //MARK: - Portrait Mode
                ZStack{
                    Color(constants.backgroundColor)
                        .ignoresSafeArea()
                    
                    VStack{
                        Image(uiImage: constants.placeHolderImage)
                            .resizable()
                            .frame(minWidth: screenWidth,
                                   idealWidth: screenWidth,
                                   maxWidth: screenWidth,
                                   minHeight: screenHeight * constants.imageHeightModifier,
                                   idealHeight: screenHeight * constants.imageHeightModifier,
                                   maxHeight: screenHeight * constants.imageHeightModifier,
                                   alignment: .center)
                        
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [constants.topGradientColor, constants.bottomGradientColor]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .padding(.top, -screenHeight * constants.rectPaddingMod)
                            .blur(radius: constants.rectRadius)
                    }
                    VStack{
                        Image(uiImage: constants.playButton)
                            .frame(minWidth: screenWidth * constants.playWidthMod,
                                   idealWidth: screenWidth * constants.playWidthMod,
                                   maxWidth: screenWidth * constants.playWidthMod,
                                   minHeight: screenHeight * constants.playHeightMod,
                                   idealHeight: screenHeight * constants.playHeightMod,
                                   maxHeight: screenHeight * constants.playHeightMod,
                                   alignment: .center)
                            
                            .padding(.top, screenHeight * constants.playPadMod)
                        Spacer()
                        if sizeClass == .compact {
                            //MARK: - Text setup for compact
                            VStack{
                                Text(constants.title)
                                    .foregroundColor(.white)
                                    
                                    .frame(maxWidth: screenWidth * constants.widthConstraint, alignment: .leading)
                                    .font(constants.fontCompactTitle)
                                
                                ScrollView {
                                    Text(constants.mockText)
                                        .font(constants.fontCompactText)
                                        .foregroundColor(.white)
                                        .frame(width: screenWidth * constants.widthConstraint)
                                }
                            }.padding(.top, screenHeight * constants.textTopPadding)
                        } else {
                            //MARK: - Text setup for regular
                            VStack{
                                Text(constants.title)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: screenWidth * constants.widthConstraint, alignment: .leading)
                                    .font(constants.fontRegularTitle)
                                
                                ScrollView {
                                    Text(constants.mockText)
                                        .font(constants.fontRegularText)
                                        .foregroundColor(.white) }
                                    .frame(width: screenWidth * constants.widthConstraint)
                            }
                            .padding(.top, screenHeight * constants.textTopPadding)
                        }
                    }
                }
                //MARK: - Landscape Mode
            } else {
                ZStack{
                    Color(constants.backgroundColor)
                        .ignoresSafeArea()
                    Image(uiImage: constants.placeHolderImage)
                        .resizable()
                        .ignoresSafeArea()
                        .frame(minWidth: screenWidth,
                               idealWidth: screenWidth,
                               maxWidth: screenWidth,
                               minHeight: screenHeight,
                               idealHeight: screenHeight,
                               maxHeight: screenHeight,
                               alignment: .center)
                    Image(uiImage: constants.playButton)
                        .frame(minWidth: screenWidth * constants.playWidthMod,
                               idealWidth: screenWidth * constants.playWidthMod,
                               maxWidth: screenWidth * constants.playWidthMod,
                               minHeight: screenHeight * constants.playHeightMod,
                               idealHeight: screenHeight * constants.playHeightMod,
                               maxHeight: screenHeight * constants.playHeightMod,
                               alignment: .center)
                        
                }
            }
        }
    }
}

struct CellDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CellDetailView().previewDevice(PreviewDevice.init(rawValue: "iPad8,1"))
        CellDetailView().previewDevice(PreviewDevice.init(rawValue: "iPhone 11"))
    }
}
