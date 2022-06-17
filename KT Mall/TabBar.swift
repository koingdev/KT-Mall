//
//  TabBar.swift
//  KT Mall
//
//  Created by KoingDev on 15/6/22.
//

import SwiftUI

struct TabItemData {
    let image: String
    let title: String
}

struct TabBarItem: View {
    let item: TabItemData
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            let color = isSelected ? Color.black : Color.gray.opacity(0.7)
            Image(systemName: item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(color)

            Text(item.title)
                .foregroundColor(color)
                .fontWeight(.medium)
                .robotoFont(14)
            
        }
    }
}

struct TabBar<Content: View>: View {
    
    let items: [TabItemData]
    @Binding var selectedIndex: Int
    @ViewBuilder let content: (Int) -> Content
    
    @State private var fadeInOut = false
    
    var body: some View {
        ZStack(alignment: .center) {
            // Page Content
            TabView(selection: $selectedIndex) {
                ForEach(items.indices, id: \.self) { index in
                    content(index)
                }
            }
            
            // Tab
            VStack {
                Spacer()
                
                VStack(alignment: .center, spacing: 0) {
                    Divider()
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        
                        ForEach(items.indices, id: \.self) { index in
                            
                            Button {
                                selectedIndex = index
                            } label: {
                                let isSelected = index == selectedIndex
                                TabBarItem(item: items[index], isSelected: isSelected)
                            }

                            Spacer()
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                    
                }
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)

            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
}
