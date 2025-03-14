//
//  CryptoImage.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 14/03/25.
//

import SwiftUI

struct CryptoImage: View {
    let icon: String

    var body: some View {
        AsyncImage(url: URL(string: icon), transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 100)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .transition(.opacity)
                    .colorMultiply(.gray.opacity(0.1))
            case .failure:
                Image(systemName: "bitcoin") // In case of error, bitcoin image will be showed by default
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray.opacity(0.5))
                    .colorMultiply(.gray.opacity(0.1))
            @unknown default:
                EmptyView()
            }
        }
    }
}
