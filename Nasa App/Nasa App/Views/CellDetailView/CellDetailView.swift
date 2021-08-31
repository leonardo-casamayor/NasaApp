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
                ZStack{
                    Color(red: 0.02, green: 0.24, blue: 0.58)
                        .ignoresSafeArea()
                    
                    VStack{
                        Image("PlaceholderCellDetails")
                            .resizable()
                            .frame(minWidth: screenWidth,
                                   idealWidth: screenWidth,
                                   maxWidth: screenWidth,
                                   minHeight: screenHeight * 0.39,
                                   idealHeight: screenHeight * 0.39,
                                   maxHeight: screenHeight * 0.39,
                                   alignment: .center)
                        
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [constants.topColor, constants.bottomColor]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .padding(.top, -screenHeight * 0.16)
                            .blur(radius: 4)
                            .shadow(radius: 2)
                    }
                    VStack{
                        Image("PlayButton")
                            .frame(minWidth: screenWidth * 0.25,
                                   idealWidth: screenWidth * 0.25,
                                   maxWidth: screenWidth * 0.25,
                                   minHeight: screenHeight * 0.15,
                                   idealHeight: screenHeight * 0.15,
                                   maxHeight: screenHeight * 0.15,
                                   alignment: .center)
                            
                            .padding(.top, screenHeight * 0.12)
                        Spacer()
                        if sizeClass == .compact {
                            //MARK: - Text setup for compact
                            VStack{
                                Text("Title, and date goes here")
                                    .foregroundColor(.white)
                                    
                                    .frame(maxWidth: screenWidth * 0.93, alignment: .leading)
                                    .font(.custom("Helvetica Regular", size: 20))
                                
                                ScrollView {
                                    Text(constants.mockText)
                                        .font(.custom("Helvetica Regular", size: 17))
                                        .foregroundColor(.white)
                                        .frame(width: screenWidth * 0.93)
                                }
                            }.padding(.top, screenHeight * 0.12)
                        } else {
                            //MARK: - Text setup for regular
                            VStack{
                                Text("Title, and date goes here")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: screenWidth * 0.93, alignment: .leading)
                                    .font(.custom("Helvetica Regular", size: 26))
                                
                                ScrollView {
                                    Text(constants.mockText)
                                        .font(.custom("Helvetica Regular", size: 23))
                                        .foregroundColor(.white) }
                                    .frame(width: screenWidth * 0.93)
                            }
                            .padding(.top, screenHeight * 0.12)
                        }
                    }
                }
                //MARK: - Landscape Mode
            } else {
                ZStack{
                    Color(red: 0.02, green: 0.24, blue: 0.58)
                        .ignoresSafeArea()
                    Image("PlaceholderCellDetails")
                        .resizable()
                        .ignoresSafeArea()
                        .frame(minWidth: screenWidth,
                               idealWidth: screenWidth,
                               maxWidth: screenWidth,
                               minHeight: screenHeight,
                               idealHeight: screenHeight,
                               maxHeight: screenHeight,
                               alignment: .center)
                    Image("PlayButton")
                        .frame(minWidth: screenWidth * 0.25,
                               idealWidth: screenWidth * 0.25,
                               maxWidth: screenWidth * 0.25,
                               minHeight: screenHeight * 0.15,
                               idealHeight: screenHeight * 0.15,
                               maxHeight: screenHeight * 0.15,
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
