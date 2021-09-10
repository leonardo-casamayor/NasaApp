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
                        VideoControllerView()
                            .cornerRadius(10)
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
                        Spacer()
                        if sizeClass == .compact {
                            //MARK: - Text setup for compact
                            VStack{
                                
                                ScrollView {
                                    Text(CellDetailConstants.title)
                                        .foregroundColor(.white)
                                        
                                        .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                        .font(Font(CellDetailConstants.fontCompactTitle as CTFont))
                                    
                                    Text(CellDetailConstants.mockText)
                                        .font(Font(CellDetailConstants.fontCompactText as CTFont))
                                        .padding(.top, CellDetailConstants.textTopPadding)
                                        .foregroundColor(.white)
                                        .frame(width: screenWidth * CellDetailConstants.widthConstraint)
                                }
                            }.padding(.top, screenHeight * CellDetailConstants.imageHeightModifier)
                        } else {
                            //MARK: - Text setup for regular
                            VStack{
                                ScrollView {
                                    Text(CellDetailConstants.title)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                        .font(Font(CellDetailConstants.fontRegularTitle as CTFont))
                                    Text(CellDetailConstants.mockText)
                                        .font(Font(CellDetailConstants.fontRegularText as CTFont))
                                        .padding(.top, CellDetailConstants.textTopPadding)
                                        .foregroundColor(.white) }
                                    .frame(width: screenWidth * CellDetailConstants.widthConstraint)
                            }
                            .padding(.top, screenHeight * CellDetailConstants.imageHeightModifier)
                        }
                    }
                }
                //MARK: - Landscape Mode
            } else {
                ZStack{
                    Color(CellDetailConstants.backgroundColor)
                        .ignoresSafeArea()
                    VideoControllerView()
                        .ignoresSafeArea()
                        .frame(width: screenWidth,
                               height: screenHeight,
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

struct VideoControllerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "VideoPlayer")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
