//
//  PagerTabStrip.swift
//  KT Mall
//
//  Created by KoingDev on 16/6/22.
//

import SwiftUI

struct PagerTabStrip<Title: View, Content: View>: View {
    
    let tintColor = Color.gray
    @Binding var selectedIndex: Int
    @State var titles: [Title]
    @ViewBuilder let content: () -> Content
    @Namespace var namespace
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in

                    HStack(alignment: .center) {
                        ForEach(titles.indices, id: \.self) { index in
                            ZStack(alignment: .center) {
                                if selectedIndex == index {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.mint.opacity(0.4))
                                        .matchedGeometryEffect(id: "underline",
                                                               in: namespace,
                                                               properties: .frame)
                                } else {
                                    Color.clear
                                }
                                
                                HStack {
                                    Image(systemName: "heart")
                                        .foregroundColor(.red)
                                    titles[index]
                                        .font(.subheadline.bold())
                                    .foregroundColor(.secondary)
                                }
                                .padding(.horizontal, 6)
                            }
                            .padding(4)
                            .frame(minWidth: screenWidth / 4, maxHeight: 48)
                            .onTapGesture {
                                selectedIndex = index
                            }
                            .onChange(of: selectedIndex) { _ in
                                withAnimation(.spring()) {
                                    proxy.scrollTo(selectedIndex)
                                }
                            }
                            .animation(.spring(), value: selectedIndex)
                        }
                    }
                }
            }
            

            
            TabView(selection: $selectedIndex) {
                content()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.spring(), value: selectedIndex)
        }
    }
    
}

extension View {
    var screenWidth: CGFloat { UIScreen.main.bounds.width }
    
    func maxWidth(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func fullScreen(alignment: Alignment = .center) -> some View {
        frame(width: screenWidth, alignment: alignment)
    }
}
