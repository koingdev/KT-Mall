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
    @State var scale: CGFloat = 1
    @State var showBackButton = true
    let animation: Namespace.ID

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button {
                    showBackButton.toggle()
                    withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 1)) {
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .robotoFont(30)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .opacity(showBackButton ? 1 : 0)
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
        .background(.white)
        .scaleEffect(scale)
        .gesture(DragGesture(minimumDistance: 0).onChanged(onChanged(value:)).onEnded(onEnded(value:)))
    }
    
    private func onChanged(value: DragGesture.Value) {
        let scaleValue = value.translation.height / screenHeight
        if 1 - scaleValue > 0.8 {
            scale = 1 - scaleValue
        }
    }
    
    private func onEnded(value: DragGesture.Value) {
        if scale < 1 {
            showBackButton.toggle()
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 1)) {
                show.toggle()
            }
            scale = 1
        }
    }
}
