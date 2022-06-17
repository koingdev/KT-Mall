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
        let isSelected = selectedIndex == index
        titles[index]
            .foregroundColor(isSelected ? tintColor : .secondary)
            .frame(minWidth: minWidth, maxHeight: maxHeight)
            .padding(6)
            .robotoFont()
            .background {
                ZStack {
                    if isSelected {
                        tintColor.opacity(0.2)
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "underline",
                                                   in: namespace,
                                                   properties: .frame)
                    }
                }
            }
            .onTapGesture {
                selectedIndex = index
            }
            .animation(.spring(), value: selectedIndex)
    }
}

struct PagerTabStripView<Title: View, Content: View>: View {
    @Binding var selectedIndex: Int
    @State var titles: [Title]
    @ViewBuilder let content: () -> Content
    @Namespace var namespace
    var tintColor = Color.mint
    @State private var previousIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(alignment: .center) {
                        ForEach(titles.indices, id: \.self) { index in
                            PagerTabStripItem(selectedIndex: $selectedIndex, titles: $titles, index: index, tintColor: tintColor, namespace: namespace)
                                .onChange(of: selectedIndex) { _ in
                                    withAnimation(.spring()) {
                                        if selectedIndex > previousIndex {
                                            let row = min(selectedIndex + 1, titles.count - 1)
                                            proxy.scrollTo(row, anchor: .leading)
                                        } else if selectedIndex < previousIndex {
                                            let row = max(selectedIndex - 1, 0)
                                            proxy.scrollTo(row, anchor: .trailing)
                                        }
                                        previousIndex = selectedIndex
                                    }
                                }
                        }
                    }
                    .padding(4)
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
