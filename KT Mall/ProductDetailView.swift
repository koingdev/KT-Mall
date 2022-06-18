//
//  ProductDetailView.swift
//  KT Mall
//
//  Created by KoingDev on 18/6/22.
//

import SwiftUI

struct ProductDetailView: View {
    @Binding var show: Bool
    @Binding var selectedProduct: Product
    let animation: Namespace.ID

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button {
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .robotoFont(30)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
            
            AsyncImage(url: selectedProduct.image) { phase in
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
            .matchedGeometryEffect(id: "image-\(selectedProduct.id)", in: animation)
            .frame(height: 380)

            
            Text(selectedProduct.name)
                .foregroundColor(.primary)
                .robotoFont()
                .padding(.horizontal, 12)
                .frame(width: screenWidth, alignment: .leading)
            
            Text(selectedProduct.description)
                .robotoFont()
                .foregroundColor(.secondary)
                .padding(.horizontal, 12)
                .frame(width: screenWidth, alignment: .leading)
            
            Text("$\(selectedProduct.price)")
                .robotoFont(18)
                .foregroundColor(.primary)
                .padding(.horizontal, 12)
                .frame(width: screenWidth, alignment: .leading)

            Spacer()
        }
        .frame(width: screenWidth)
        .background(.white)
    }
}
