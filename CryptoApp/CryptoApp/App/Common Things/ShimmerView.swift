//
//  ShimmerView.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 14/03/25.
//

import SwiftUI

struct ShimmerView: View {
    let geometryProxy: GeometryProxy

    @State private var shimmerOffset: CGFloat = -1.0
    
    private var layoutSystem: CGFloat {
        geometryProxy.size.width > geometryProxy.size.height ? 4.0 : 2.0
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.clear.opacity(0.3))
                .frame(minWidth: 150, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray.opacity(0.3), lineWidth: 2)
                }
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(minWidth: 150, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
                .overlay(
                    Text("Loading...")
                        .foregroundColor(.gray)
                )
                .mask(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.0),
                            Color.white.opacity(0.2),
                            Color.white.opacity(0.4),
                            Color.white.opacity(0.6),
                            Color.white.opacity(0.7),
                            Color.white.opacity(0.6),
                            Color.white.opacity(0.4),
                            Color.white.opacity(0.2),
                            Color.white.opacity(0.0)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(minWidth: 150, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
                    .offset(x: shimmerOffset * (geometryProxy.size.width / layoutSystem))
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        withAnimation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false)) {
                            shimmerOffset = 1.0
                        }
                    }
                }
        }
    }
}

