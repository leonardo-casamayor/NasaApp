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
    var nasaData: NasaData
    var assetUrl: String
    
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
                        if nasaData.mediaType == MediaType.image {
                            Image(uiImage: loadImage())
                                .frame(width: screenWidth,
                                       height: screenHeight * CellDetailConstants.imageHeightModifier,
                                       alignment: .center)
                        }
                        else {
                        VideoControllerView(videoUrl: assetUrl)
                            .cornerRadius(10)
                            .frame(width: screenWidth,
                                   height: screenHeight * CellDetailConstants.imageHeightModifier,
                                   alignment: .center)
                        }
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
                                    Text(nasaData.title)
                                        .foregroundColor(.white)
                                        
                                        .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                        .font(Font(CellDetailConstants.fontCompactTitle as CTFont))
                                    
                                    Text(nasaData.description)
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
                                    Text(nasaData.title)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                        .font(Font(CellDetailConstants.fontRegularTitle as CTFont))
                                    Text(nasaData.description)
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
                    if nasaData.mediaType == MediaType.image {
                        Image(uiImage: loadImage())
                            .frame(width: screenWidth,
                                   height: screenHeight * CellDetailConstants.imageHeightModifier,
                                   alignment: .center)
                    }
                    else {
                    VideoControllerView(videoUrl: assetUrl)
                        .cornerRadius(10)
                        .frame(width: screenWidth,
                               height: screenHeight * CellDetailConstants.imageHeightModifier,
                               alignment: .center)
                    }
                }
            }
        }
    }
    func loadImage() -> UIImage {
        guard let urlRequest = URL(string: assetUrl) else { return UIImage() }
        do {
        let data: Data = try Data(contentsOf: urlRequest)
            return UIImage(data: data) ?? UIImage()
        }
        catch {
            return UIImage()
        }
    }
}

struct VideoControllerView: UIViewControllerRepresentable {
    var videoUrl: String
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: CellDetailConstants.storyboardID, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: CellDetailConstants.videoPlayerID) as! VideoPlayerViewController
        controller.videoUrl = videoUrl
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
