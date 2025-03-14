//
//  DetailView.swift
//  CryptoApp
//
//  Created Gabriel Alejandro Briseño Alvarez on 13/03/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//

import SwiftUI

struct DetailView: View {
    @Binding var coinObject: CoinObject

    @State private var viewModel: DetailViewViewModelProtocol = DetailViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .neumorphicDark() : .neumorphicLight()
    }

    var body: some View {
        VStack {
            Text("Howdy there!")
        }
        .navigationTitle(coinObject.name ?? "Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                getFavoritedButton()
            }
        }
    }
}

private extension DetailView {
    func getFavoritedButton() -> some View {
        Button(action: {
            withAnimation {
                coinObject.isFavorited.toggle()
            }
        }) {
            Image(systemName: coinObject.isFavorited ? "star.fill" : "star")
                .foregroundStyle(coinObject.isFavorited ? Color.red : Color.primary)
        }
    }
}

#Preview {
    DetailView(coinObject: .constant(CoinObject(identifiable: nil,
                                                symbol: "APPL",
                                                name: "Apple Inc",
                                                image: "",
                                                current_price: 4200,
                                                market_cap: 5000,
                                                total_volume: 1000000,
                                                high_24h: 4800,
                                                low_24h: 3950,
                                                price_change_24h: 4000,
                                                last_updated: "")))
}
