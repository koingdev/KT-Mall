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
    @ViewBuilder let title: () -> Title
    @ViewBuilder let content: () -> Content
    
    @State var scrollOffset: CGFloat = 0
    @State var tabOffset: CGFloat = 0
    @State var maxTab: CGFloat = 0
    
    private var pagerTabWidth: CGFloat {
        maxTab == 0 ? 0 : screenWidth / maxTab
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                title()
                    .maxWidth()
            }.overlay{
                HStack(spacing: 0) {
                    ForEach(0..<Int(maxTab), id: \.self) { index in
                        Rectangle()
                            .fill(.black.opacity(0.001))
                            .onTapGesture {
                                let offsetBasedOnIndex = CGFloat(index) * screenWidth
                                scrollOffset = offsetBasedOnIndex
                            }
                    }
                }
            }
            
            Capsule()
                .fill(tintColor)
                .frame(width: pagerTabWidth, height: 4)
                .maxWidth(alignment: .leading)
                .padding(.top, 5)
                .offset(x: tabOffset)
            
            PagingScrollView(selectedIndex: $selectedIndex, offset: $scrollOffset) {
                LazyHStack(spacing: 0) {
                    content()
                        .fullScreen()
                }
                .overlay {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: PagerPreferenceKey.self, value: proxy.frame(in: .named("PagingScrollView")))
                    }
                }
                .onPreferenceChange(PagerPreferenceKey.self) { proxyFrame in
                    let minX = -proxyFrame.minX
                    let maxWidth = proxyFrame.width
                    maxTab = (maxWidth / screenWidth).rounded()
                    
                    let progress = minX / screenWidth
                    tabOffset = progress * pagerTabWidth
                }
            }
            .coordinateSpace(name: "PagingScrollView")
        }
    }
    
}

struct PagerPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGRect = .init()
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
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

struct PagerTabStrip_Previews: PreviewProvider {
    @State static var index = 0
    static var previews: some View {
        PagerTabStrip(selectedIndex: $index) {
            Text("Sun Screen")
            Text("Face Mask")
            Text("Body")
        } content: {
            Color.blue
            Color.red
            Color.yellow
        }
        
    }
}
