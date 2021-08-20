//
//  CellDetailView.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 19/08/2021.
//

import SwiftUI
import AVKit

struct CellDetailView: View {
    // MARK: - Mock Data here
    private let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    let mockText = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.he standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    
    // MARK: - Mock ends here
    let topColor = Color(red: 0.04, green: 0.44, blue: 0.78, opacity: 0.07)
    let bottomColor = Color(red: 0.02, green: 0.24, blue: 0.58)
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                Color(red: 0.02, green: 0.24, blue: 0.58)
                    .ignoresSafeArea()
                
                VStack{
                    // VideoPlayer should work, leaving an image as placeholder for now.
                    //                    VideoPlayer(player: player)
                    //                        .onAppear() {
                    //                            player.play()
                    //                        }
                    Image("PlaceholderCellDetails")
                        .resizable()
                        .frame(minWidth: geometry.size.width,
                               idealWidth: geometry.size.width,
                               maxWidth: geometry.size.width,
                               minHeight: geometry.size.height * 0.39,
                               idealHeight: geometry.size.height * 0.39,
                               maxHeight: geometry.size.height * 0.39,
                               alignment: .center)
                    
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .padding(.top, -geometry.size.height * 0.16)
                        .blur(radius: 4)
                        .shadow(radius: 2)
                }
                VStack{
                    Image("PlayButton")
                        .frame(minWidth: geometry.size.width * 0.25,
                               idealWidth: geometry.size.width * 0.25,
                               maxWidth: geometry.size.width * 0.25,
                               minHeight: geometry.size.height * 0.15,
                               idealHeight: geometry.size.height * 0.15,
                               maxHeight: geometry.size.height * 0.15,
                               alignment: .center)
                        
                        .padding(.top, geometry.size.height * 0.12)
                    Spacer()
                    if sizeClass == .compact {
                        //MARK: - Text setup for compact
                        VStack{
                            Text("Title, and date goes here")
                                .foregroundColor(.white)
                                
                                .frame(maxWidth: geometry.size.width * 0.93, alignment: .leading)
                                .font(.custom("Helvetica Regular", size: 20))
                            
                            ScrollView {
                                Text(mockText)
                                    
                                    .font(.custom("Helvetica Regular", size: 17))
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width * 0.93)
                                
                            }
                        }.padding(.top, geometry.size.height * 0.12)
                    } else {
                        //MARK: - Text setup for regular
                        VStack{
                            Text("Title, and date goes here")
                                .foregroundColor(.white)
                                
                                .frame(maxWidth: geometry.size.width * 0.93, alignment: .leading)
                                .font(.custom("Helvetica Regular", size: 26))
                            
                            ScrollView {
                                Text(mockText)
                                    
                                    .font(.custom("Helvetica Regular", size: 23))
                                    .foregroundColor(.white) }
                                .frame(width: geometry.size.width * 0.93)
                            
                        }
                        .padding(.top, geometry.size.height * 0.12)
                    }
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
