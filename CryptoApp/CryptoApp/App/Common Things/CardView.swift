//
//  CardView.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 14/03/25.
//

import SwiftUI

struct CardView: View {
    @FormattedPrice
    var currentPrice: String
    @FormattedDate
    var date: String

    let icon: String
    let isFavorited: Bool
    let name: String
    let symbol: String
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            CryptoImage(icon: icon)
            VStack(alignment: .leading, spacing: 5) {
                if isFavorited {
                    HStack {
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                    }
                }
                HStack(alignment: .lastTextBaseline) {
                    Text(name)
                        .font(.title2)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    Text(symbol)
                        .font(.callout)
                        .foregroundStyle(Color(.systemGray))
                }
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                    }
                    Text("$\(currentPrice)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    Spacer()
                    Text(date)
                        .font(.footnote)
                        .foregroundStyle(Color(.systemGray))
                }
            }
        }
        .padding(10)
    }
}

#Preview {
    CardView(currentPrice: "5000",
             date: "March 13, 2025 10:00",
             icon: "",
             isFavorited: false,
             name: "APPLE INC",
             symbol: "APPL")
}
