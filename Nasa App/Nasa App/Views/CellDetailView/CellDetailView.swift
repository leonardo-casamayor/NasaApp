//
//  CellDetailView.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 19/08/2021.
//

import SwiftUI
import AVKit


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
                    Color(CellDetailConstants.backgroundColor)
                        .ignoresSafeArea()
                    
                    VStack{
                        Image(uiImage: CellDetailConstants.placeHolderImage)
                            .resizable()
                            .frame(minWidth: screenWidth,
                                   idealWidth: screenWidth,
                                   maxWidth: screenWidth,
                                   minHeight: screenHeight * CellDetailConstants.imageHeightModifier,
                                   idealHeight: screenHeight * CellDetailConstants.imageHeightModifier,
                                   maxHeight: screenHeight * CellDetailConstants.imageHeightModifier,
                                   alignment: .center)
                        
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [CellDetailConstants.topGradientColor, CellDetailConstants.bottomGradientColor]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .ignoresSafeArea()
                            .padding(.top, -screenHeight * CellDetailConstants.rectPaddingMod)
                            
                    }
                    VStack{
                        Image(uiImage: CellDetailConstants.playButton)
                            .frame(minWidth: screenWidth * CellDetailConstants.playWidthMod,
                                   idealWidth: screenWidth * CellDetailConstants.playWidthMod,
                                   maxWidth: screenWidth * CellDetailConstants.playWidthMod,
                                   minHeight: screenHeight * CellDetailConstants.playHeightMod,
                                   idealHeight: screenHeight * CellDetailConstants.playHeightMod,
                                   maxHeight: screenHeight * CellDetailConstants.playHeightMod,
                                   alignment: .center)
                            
                            .padding(.top, screenHeight * CellDetailConstants.playPadMod)
                        Spacer()
                        if sizeClass == .compact {
                            //MARK: - Text setup for compact
                            VStack{
                                Text(CellDetailConstants.title)
                                    .foregroundColor(.white)
                                    
                                    .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                    .font(CellDetailConstants.fontCompactTitle)
                                
                                ScrollView {
                                    Text(CellDetailConstants.mockText)
                                        .font(CellDetailConstants.fontCompactText)
                                        .foregroundColor(.white)
                                        .frame(width: screenWidth * CellDetailConstants.widthConstraint)
                                }
                            }.padding(.top, screenHeight * CellDetailConstants.textTopPadding)
                        } else {
                            //MARK: - Text setup for regular
                            VStack{
                                Text(CellDetailConstants.title)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                    .font(CellDetailConstants.fontRegularTitle)
                                
                                ScrollView {
                                    Text(CellDetailConstants.mockText)
                                        .font(CellDetailConstants.fontRegularText)
                                        .foregroundColor(.white) }
                                    .frame(width: screenWidth * CellDetailConstants.widthConstraint)
                            }
                            .padding(.top, screenHeight * CellDetailConstants.textTopPadding)
                        }
                    }
                }
                //MARK: - Landscape Mode
            } else {
                ZStack{
                    Color(CellDetailConstants.backgroundColor)
                        .ignoresSafeArea()
                    Image(uiImage: CellDetailConstants.placeHolderImage)
                        .resizable()
                        .ignoresSafeArea()
                        .frame(minWidth: screenWidth,
                               idealWidth: screenWidth,
                               maxWidth: screenWidth,
                               minHeight: screenHeight,
                               idealHeight: screenHeight,
                               maxHeight: screenHeight,
                               alignment: .center)
                    Image(uiImage: CellDetailConstants.playButton)
                        .frame(minWidth: screenWidth * CellDetailConstants.playWidthMod,
                               idealWidth: screenWidth * CellDetailConstants.playWidthMod,
                               maxWidth: screenWidth * CellDetailConstants.playWidthMod,
                               minHeight: screenHeight * CellDetailConstants.playHeightMod,
                               idealHeight: screenHeight * CellDetailConstants.playHeightMod,
                               maxHeight: screenHeight * CellDetailConstants.playHeightMod,
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
