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
                            .frame(width: screenWidth,
                                   height: screenHeight * CellDetailConstants.imageHeightModifier,
                                   alignment: .center)
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(CellDetailConstants.topGradientColor), Color(CellDetailConstants.bottomGradientColor)]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .ignoresSafeArea()
                            .padding(.top, -screenHeight * CellDetailConstants.rectPaddingMod)
                            
                    }
                    VStack{
                        Image(uiImage: CellDetailConstants.playButton)
                            .frame(width: screenWidth * CellDetailConstants.playWidthMod,
                                   height: screenHeight * CellDetailConstants.playHeightMod,
                                   alignment: .center)
                            
                            .padding(.top, screenHeight * CellDetailConstants.playPadMod)
                        Spacer()
                        if sizeClass == .compact {
                            //MARK: - Text setup for compact
                            VStack{
                                Text(CellDetailConstants.title)
                                    .foregroundColor(.white)
                                    
                                    .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                    .font(Font(CellDetailConstants.fontCompactTitle as CTFont))
                                
                                ScrollView {
                                    Text(CellDetailConstants.mockText)
                                        .font(Font(CellDetailConstants.fontCompactText as CTFont))
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
                                    .font(Font(CellDetailConstants.fontRegularTitle as CTFont))
                                
                                ScrollView {
                                    Text(CellDetailConstants.mockText)
                                        .font(Font(CellDetailConstants.fontRegularText as CTFont))
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
                        .frame(width: screenWidth,
                               height: screenHeight,
                               alignment: .center)
                    Image(uiImage: CellDetailConstants.playButton)
                        .frame(width: screenWidth * CellDetailConstants.playWidthMod,
                               height: screenHeight * CellDetailConstants.playHeightMod,
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
