//
//  ContentView.swift
//  KT Mall
//
//  Created by KoingDev on 15/6/22.
//

import SwiftUI

struct ContentView: View {
    @State var pagerSelectedIndex = 0
    @State var tabSelectedIndex = 0
    let tabs: [TabItemData] = [
        TabItemData(image: "house.fill", title: "Home"),
        TabItemData(image: "cart.fill", title: "Cart"),
        TabItemData(image: "heart.fill", title: "Favorite"),
        TabItemData(image: "person.circle.fill", title: "Account")
    ]

    var body: some View {
        TabBar(items: tabs, selectedIndex: $tabSelectedIndex) { index in
            PagerTabStrip(selectedIndex: $pagerSelectedIndex, titles: [
                Text("Sun Screen"),
                Text("Face Mask"),
                Text("Body"),
                Text("Best Seller")
            ]) {
                Color.mint.tag(0)
                Color.blue.tag(1)
                Color.yellow.tag(2)
                Color.brown.tag(3)
            }
            .tag(0)
            
            Text("Cart")
                .tag(1)
            Text("Favorites")
                .tag(2)
            Text("Account")
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
