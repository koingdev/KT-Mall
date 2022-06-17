//
//  ProductCardView.swift
//  KT Mall
//
//  Created by KoingDev on 17/6/22.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: Double
    let image: URL?
}

struct ProductCardView: View {
    var product: Product
    var animation: Namespace.ID

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: product.image) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Failed to load")
                        .robotoFont(15)
                        .foregroundColor(.secondary)
                } else {
                    ProgressView()
                }
            }
            .frame(height: 160)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .robotoFont(15)
                
                HStack {
                    Text("\(product.price)$")
                        .foregroundColor(.secondary)
                        .robotoFont(17)
                    Spacer()
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.pink.opacity(0.7))
                }
            }.padding(12)
        }
        .frame(height: 280)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder()
                .foregroundColor(.secondary.opacity(0.2))
        )
    }
}

struct ProductCardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ProductCardView(product: Product(name: "Nile All-in-One Lotion Lotion Aftershave (Lafrance Scent)", description: "Beauty", price: 20, image: URL(string: "https://m.media-amazon.com/images/I/61xsYkg4p0L._AC_UL640_FMwebp_QL65_.jpg")), animation: namespace)
    }
}
