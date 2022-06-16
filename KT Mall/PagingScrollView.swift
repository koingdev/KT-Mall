//
//  PagingScrollView.swift
//  KT Mall
//
//  Created by KoingDev on 17/6/22.
//

import UIKit
import SwiftUI

struct PagingScrollView<Content: View>: UIViewRepresentable {
    @Binding var selectedIndex: Int
    @Binding var offset: CGFloat
    @ViewBuilder var content: () -> Content
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        
        let hostView = UIHostingController(rootView: content())
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostView.view)
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostView.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]
        scrollView.addConstraints(constraints)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        let currentOffset = uiView.contentOffset.x
        if currentOffset != offset {
            // Auto scroll when offset update
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: PagingScrollView
        
        init(parent: PagingScrollView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            let maxWidth = scrollView.contentSize.width
            let selectedIndex = (offset / maxWidth).rounded()
            parent.selectedIndex = Int(selectedIndex)
            parent.offset = offset
        }
    }
}
