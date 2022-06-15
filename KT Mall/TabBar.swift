//
//  TabBar.swift
//  KT Mall
//
//  Created by KoingDev on 15/6/22.
//

import SwiftUI

struct TabBar<Content>: View where Content: View {
    
    @State var images: [Image]
    @State var titles: [String]
    @State var tabIndex: Int
    @State var contents: [Content]
    
    @State private var fadeInOut = false
    
    var body: some View {
        ZStack(alignment: .center) {
            
            // Page Content
            ForEach(contents.indices, id: \.self) { i in
                if i == tabIndex {
                    contents[i]
                        .opacity(fadeInOut ? 0 : 1)
                }
            }
            
            // Tab
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Divider()

                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        ForEach(images.indices, id: \.self) { i in
                            VStack(spacing: 2) {
                                let color = i == tabIndex ? Color.black : Color.gray.opacity(0.7)
                                images[i]
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(color)

                                Text(titles[i])
                                    .foregroundColor(color)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                
                            }
                            .onTapGesture {
                                if i == tabIndex { return }

                                fadeInOut = tabIndex != i
                                tabIndex = i
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    fadeInOut.toggle()
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                    
                }
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: -2)
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var images: [Image] = [
        Image(systemName: "house.fill"),
        Image(systemName: "cart.fill"),
        Image(systemName: "heart.fill"),
        Image(systemName: "gear")
    ]
    static var titles: [String] = [
        "Home",
        "Cart",
        "Favorite",
        "Settings"
    ]
    static var previews: some View {
        TabBar(images: images, titles: titles, tabIndex: 0, contents: [
            Text("Home"),
            Text("Cart"),
            Text("Favorites"),
            Text("Settings")
        ])
    }
}
