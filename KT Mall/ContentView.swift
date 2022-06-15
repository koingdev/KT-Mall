//
//  ContentView.swift
//  KT Mall
//
//  Created by KoingDev on 15/6/22.
//

import SwiftUI

struct ContentView: View {
    var images: [Image] = [
        Image(systemName: "house.fill"),
        Image(systemName: "cart.fill"),
        Image(systemName: "heart.fill"),
        Image(systemName: "person.circle.fill")
    ]
    var titles: [String] = [
        "Home",
        "Cart",
        "Favorite",
        "Settings"
    ]
    var body: some View {
        TabBar(images: images, titles: titles, tabIndex: 0, contents: [
            Text("Home"),
            Text("Cart"),
            Text("Favorites"),
            Text("Settings")
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
