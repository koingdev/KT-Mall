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
    var isFavorite = false
    
    static func empty() -> Product { Product(name: "", description: "", price: 0, image: nil) }
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
                        .robotoFont()
                        .foregroundColor(.secondary)
                } else {
                    ProgressView()
                }
            }
            .matchedGeometryEffect(id: "image-\(product.id)", in: animation)
            .frame(height: 160)

            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .foregroundColor(.primary)
                    .robotoFont()
                    .lineLimit(2)
                
                HStack {
                    Text("$\(product.price)")
                        .foregroundColor(.secondary)
                        .robotoFont(16)

                    Spacer()
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 18)
                        .foregroundColor(.pink.opacity(0.7))
                }
            }
            .padding(8)
        }
        .background(.white)
        .frame(height: 250)
        .mask(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
    }
}

struct ProductCardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ProductCardView(product: Product(name: "Nile All-in-One Lotion Lotion Aftershave (Lafrance Scent)", description: "Beauty", price: 20, image: URL(string: "https://m.media-amazon.com/images/I/61xsYkg4p0L._AC_UL640_FMwebp_QL65_.jpg")), animation: namespace)
    }
}
