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
    let name: String
    let symbol: String
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack(alignment: .bottomLeading) {
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
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.yellow)
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
             name: "APPLE INC",
             symbol: "APPL")
}
