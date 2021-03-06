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
    @State var products: [Product] = [
        Product(name: "Nile All-in-One Lotion Lotion Aftershave (Lafrance Scent)", description: "Beauty", price: 20, image: URL(string: "https://d28qg0el9tv5wv.cloudfront.net/data/img/items/TPS-1d-10-dtp/thum_640x640.jpg")),
        Product(name: "Anessa Perfect UV", description: "Beauty", price: 20, image: URL(string: "https://m.media-amazon.com/images/I/51ejRtSqzPL._AC_UL640_FMwebp_QL65_.jpg")),
        Product(name: "Nile Mud Pack, Pore Pack, Peeling, Blackhead, Exfoliating Removal, 2.5 oz (70 g)", description: "Beauty", price: 20, image: URL(string: "https://m.media-amazon.com/images/I/811az203tLL._AC_UL640_FMwebp_QL65_.jpg")),
        Product(name: "Keana Nadeshiko rice mask, 10 sheets", description: "Beauty", price: 20, image: URL(string: "https://m.media-amazon.com/images/I/61vBBpJwGjL._AC_UL640_FMwebp_QL65_.jpg")),
        Product(name: "himecoto White Waki White R1 18g (x1)", description: "Beauty", price: 20, image: URL(string: "https://m.media-amazon.com/images/I/61H367sXrLL._AC_SX679_.jpg")),
        Product(name: "Klairs Freshly Juiced Vitamin C Drop, Korean Cosmetics, Pure Vitamin C, Vitamin C Serum, Hypoallergenic, 1.18 oz (35 ml)", description: "Beauty", price: 20, image: URL(string: "https://m.media-amazon.com/images/I/6131DHA+O8L._AC_UL640_FMwebp_QL65_.jpg")),
        Product(name: "ETUDE Official Play Color Eye Shadow Autumn Closet, 0.03 oz (0.7 g) x 10 Colors", description: "Beauty", price: 20, image: URL(string: "https://m.media-amazon.com/images/I/610JlxlYXDL._AC_UL640_FMwebp_QL65_.jpg"))
    ]
    @Namespace var productCardAnimation
    @State var showDetail = false
    @State var selectedProduct: Product = .empty()

    var body: some View {
        ZStack {
            TabBar(items: tabs, selectedIndex: $tabSelectedIndex) { index in
                // First tab
                PagerTabStripView(selectedIndex: $pagerSelectedIndex, titles: [
                    Text("Best Seller"),
                    Text("Sun Screen"),
                    Text("Face Mask"),
                    Text("Body")
                ]) {
                    ProductGridView(products: $products, animation: productCardAnimation) { product in
                        withAnimation(.spring()) {
                            showDetail.toggle()
                            selectedProduct = product
                        }
                    }.tag(0)

                    ProductGridView(products: $products, animation: productCardAnimation) { product in
                        selectedProduct = product
                    }.tag(1)
                    
                    ProductGridView(products: $products, animation: productCardAnimation) { product in
                        selectedProduct = product
                    }.tag(2)
                    
                    ProductGridView(products: $products, animation: productCardAnimation) { product in
                        selectedProduct = product
                    }.tag(3)

                }
                .tag(0)
                

                Text("Cart")
                    .tag(1)
                Text("Favorites")
                    .tag(2)
                Text("Account")
                    .tag(3)
            }
            
            

            if showDetail {
                ProductDetailView(show: $showDetail, selectedProduct: $selectedProduct, animation: productCardAnimation)
                    .zIndex(1)  // Always make sure it's on top
            }
        }
    }
}

extension View {
    func robotoFont(_ size: CGFloat = 14) -> some View {
        font(Font.custom("HelveticaNeue", size: size))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
