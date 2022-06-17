//
//  PagerTabStrip.swift
//  KT Mall
//
//  Created by KoingDev on 16/6/22.
//

import SwiftUI

struct PagerTabStripItem<Title: View>: View {
    @Binding var selectedIndex: Int
    @Binding var titles: [Title]
    var index: Int
    let tintColor: Color
    let namespace: Namespace.ID
    let maxHeight: CGFloat = 48
    var minWidth: CGFloat { screenWidth / 4 }

    var body: some View {
        ZStack(alignment: .center) {
            let isSelected = selectedIndex == index
            if isSelected {
                RoundedRectangle(cornerRadius: 20)
                    .fill(tintColor.opacity(0.2))
                    .matchedGeometryEffect(id: "underline",
                                           in: namespace,
                                           properties: .frame)
            } else {
                Color.clear
            }
            
            titles[index]
                .foregroundColor(isSelected ? tintColor : .secondary)
                .padding(.horizontal, 6)
                .robotoFont()
        }
        .padding(4)
        .frame(minWidth: minWidth, maxHeight: maxHeight)
        .onTapGesture {
            selectedIndex = index
        }
        .animation(.spring(), value: selectedIndex)
    }
}

struct PagerTabStrip<Title: View, Content: View>: View {
    @Binding var selectedIndex: Int
    @State var titles: [Title]
    @ViewBuilder let content: () -> Content
    @Namespace var namespace
    var tintColor = Color.mint
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(alignment: .center) {
                        ForEach(titles.indices, id: \.self) { index in
                            PagerTabStripItem(selectedIndex: $selectedIndex, titles: $titles, index: index, tintColor: tintColor, namespace: namespace)
                            .onChange(of: selectedIndex) { _ in
                                withAnimation(.spring()) {
                                    proxy.scrollTo(selectedIndex, anchor: .trailing)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 6)
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
}
