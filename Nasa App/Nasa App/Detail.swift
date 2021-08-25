//
//  Detail.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 24/08/2021.
//

import SwiftUI

struct Detail: View {
    var body: some View {
        ZStack {
            Spacer().ignoresSafeArea().background(Color.blue)
        GeometryReader { geo in
            VStack {
            Text("Video view area")
                .frame(width: geo.size.width, height: geo.size.height * 0.45, alignment: .center)
                .background(Color.red)
                ScrollView {
                    Text("Scroll view area")
                        
                }.frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                .background(Color.red)
                
        }
            
        }
        .background(Color.blue)
        .edgesIgnoringSafeArea(.top)
            

        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail()
    }
}
