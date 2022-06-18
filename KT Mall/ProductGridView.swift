//
//  ProductGridView.swift
//  KT Mall
//
//  Created by KoingDev on 18/6/22.
//

import SwiftUI

struct ProductGridView: View {
    @Binding var products: [Product]
    let animation: Namespace.ID
    let didSelectProduct: (Product) -> Void

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                ForEach(products, id: \.id) { product in
                    ProductCardView(product: product, animation: animation)
                        .onTapGesture {
                            didSelectProduct(product)
                        }
                }
            }
            .padding(8)
        }
        .background(Color.gray.opacity(0.1))
    }
}
