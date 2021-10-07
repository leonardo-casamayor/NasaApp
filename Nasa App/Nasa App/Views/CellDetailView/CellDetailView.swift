//
//  CellDetailView.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 19/08/2021.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI


struct CellDetailView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    var nasaData: NasaData
    var assetUrl: String
    var nasaDateString: String
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            let isPortrait = screenHeight > screenWidth
            
            if isPortrait || nasaData.mediaType == MediaType.image {
                //MARK: - Portrait Mode
                ZStack{
                    Color(CellDetailConstants.backgroundColor)
                        .ignoresSafeArea()
                    
                    if nasaData.mediaType == MediaType.image {
                        VStack{
                            WebImage(url: URL(string: assetUrl))
                                .resizable()
                                .placeholder {
                                        Rectangle().foregroundColor(.black)
                                    }
                                .indicator(.activity)
                                .scaledToFill()
                                .transition(.fade(duration: 0.5))
                                .frame(width: screenWidth,
                                       height: screenHeight,
                                       alignment: .center)
                                .clipped()
                                .cornerRadius(10)
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(CellDetailConstants.topGradientColor), Color(CellDetailConstants.bottomGradientColor)]),
                                                     startPoint: .top,
                                                     endPoint: .bottom))
                                
                                .ignoresSafeArea()
                                .padding(.top, -screenHeight )
                        }
                        VStack{
                            Spacer()
                            if sizeClass == .compact {
                                //MARK: - Text setup for compact
                                VStack{
                                    
                                    ScrollView {
                                        Text("\(nasaData.title) / \(nasaDateString)")
                                            .foregroundColor(.white)
                                            
                                            .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                            .font(Font(CellDetailConstants.fontCompactTitle as CTFont))
                                        
                                        Text(nasaData.description)
                                            .font(Font(CellDetailConstants.fontCompactText as CTFont))
                                            .padding(.top, CellDetailConstants.textTopPadding)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .frame(width: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                    }
                                }.padding(.top, screenHeight * 0.5)
                                
                            } else {
                                //MARK: - Text setup for regular
                                VStack{
                                    ScrollView {
                                        Text("\(nasaData.title) / \(nasaDateString)")
                                            .foregroundColor(.white)
                                            .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                            .font(Font(CellDetailConstants.fontRegularTitle as CTFont))
                                        Text(nasaData.description)
                                            .font(Font(CellDetailConstants.fontRegularText as CTFont))
                                            .padding(.top, CellDetailConstants.textTopPadding)
                                            .foregroundColor(.white) }
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)

                                        .frame(width: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                }
                                .padding(.top, screenHeight * 0.5)
                            }
                        }
                        
                    }
                    else {
                        VStack {
                            if sizeClass == .compact {
                            VideoControllerView(videoUrl: assetUrl)
                                .cornerRadius(10)
                                .frame(width: screenWidth,
                                       height: screenHeight * CellDetailConstants.imageHeightModifier,
                                       alignment: .center)
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(CellDetailConstants.topGradientColor), Color(CellDetailConstants.bottomGradientColor)]),
                                                     startPoint: .top,
                                                     endPoint: .bottom))
                                .ignoresSafeArea()
                            } else {
                                VideoControllerView(videoUrl: assetUrl)
                                    .cornerRadius(10)
                                    .frame(width: screenWidth,
                                           height: screenHeight * 0.5,
                                           alignment: .center)
                                Rectangle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(CellDetailConstants.topGradientColor), Color(CellDetailConstants.bottomGradientColor)]),
                                                         startPoint: .top,
                                                         endPoint: .bottom))
                                    .ignoresSafeArea()
                            }
                        }
                        VStack{
                            Spacer()
                            if sizeClass == .compact {
                                //MARK: - Text setup for compact
                                VStack{
                                    
                                    ScrollView {
                                        Text("\(nasaData.title) / \(nasaDateString)")
                                            .foregroundColor(.white)
                                            .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                            .font(Font(CellDetailConstants.fontCompactTitle as CTFont))
                                        
                                        Text(nasaData.description)
                                            .font(Font(CellDetailConstants.fontCompactText as CTFont))
                                            .padding(.top, CellDetailConstants.textTopPadding)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .frame(width: screenWidth * CellDetailConstants.widthConstraint)

                                }.padding(.top, screenHeight * CellDetailConstants.imageHeightModifier)
                            } else {
                                //MARK: - Text setup for regular
                                VStack{
                                    ScrollView {
                                        Text("\(nasaData.title) / \(nasaDateString)")
                                            .foregroundColor(.white)
                                            .frame(maxWidth: screenWidth * CellDetailConstants.widthConstraint, alignment: .leading)
                                            .font(Font(CellDetailConstants.fontRegularTitle as CTFont))
                                        Text(nasaData.description)
                                            .font(Font(CellDetailConstants.fontRegularText as CTFont))
                                            .padding(.top, CellDetailConstants.textTopPadding)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)

                                    }
                                        .frame(width: screenWidth * CellDetailConstants.widthConstraint)
                                }
                                .padding(.top, screenHeight * 0.5)
                            }
                        }
                        
                        
                        
                    }
                    
                }
                //MARK: - Landscape Mode
            } else {
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                    if nasaData.mediaType == MediaType.video {
                        
                        VideoControllerView(videoUrl: assetUrl)
                            .cornerRadius(10)
                            .ignoresSafeArea()
                            .frame(width: screenWidth,
                                   height: screenHeight,
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
