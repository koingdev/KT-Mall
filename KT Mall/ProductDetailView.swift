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
            ZStack(alignment: .top) {
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
                
                HStack {
                    Button {
                        showBackButton.toggle()
                        withAnimation(.spring()) {
                            show.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .opacity(showBackButton ? 1 : 0)
                .padding()
            }

            
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
            scale = min(1 - scaleValue, 1)
        }
    }
    
    private func onEnded(value: DragGesture.Value) {
        if scale < 1 {
            showBackButton.toggle()
            withAnimation(.spring()) {
                show.toggle()
            }
            scale = 1
        }
    }
}
