//
//  DetailView.swift
//  CryptoApp
//
//  Created Gabriel Alejandro Briseño Alvarez on 13/03/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//

import Charts
import Foundation
import SwiftUI

struct DetailView: View {
    @Binding var coinObject: CoinObject

    @State private var viewModel: DetailViewViewModelProtocol = DetailViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .neumorphicDark() : .neumorphicLight()
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if geometry.size.width < geometry.size.height {
                    VStack {
                        getChartView()
                        getDetailsView()
                    }
                } else {
                    HStack {
                        getChartView()
                        getDetailsView()
                    }
                }
            }
        }
        .padding(20)
        .background(backgroundColor)
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
                .foregroundStyle(coinObject.isFavorited ? Color.yellow : Color.yellow)
        }
    }
    
    func getChartView() -> some View {
        NeumorphicView(isInteractive: false)
            .frame(height: 300)
            .overlay {
                Chart(viewModel.plots) { plot in
                    LineMark(x: .value("Quarters", plot.x), y: .value("Value", plot.y))
                        .foregroundStyle(Color.purple)
                    RuleMark(y: .value("Goal", 75))
                        .foregroundStyle(Color.green)
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: [10]))
                        .annotation(alignment: .leading) {
                            Text("Early")
                        }
                        .annotation(alignment: .trailing) {
                            Text("Late")
                        }
                        .annotation(position: .bottom, alignment: .trailing, spacing: 8) {
                            Text("Exceed expectations")
                        }
                }
                .padding(20)
                .clipped()
            }
    }
    
    func getDetailsView() -> some View {
        NeumorphicView(isInteractive: false)
            .frame(height: 300)
            .overlay {
                ZStack {
                    CryptoImage(icon: coinObject.image ?? "")
                    VStack(spacing: 10) {
                        HStack(alignment: .lastTextBaseline) {
                            Text(coinObject.name ?? "")
                                .font(.title)
                            Text("•")
                            Text(coinObject.symbol ?? "")
                                .font(.callout)
                                .foregroundStyle(Color(.systemGray))
                        }
                        Spacer()
                        getRow(with: "Total Volume:", value: "\(coinObject.total_volume ?? 0)")
                        getRow(with: "Highest Price:", value: getFormattedPrice(for: coinObject.high_24h))
                        getRow(with: "Lowest Price:", value: getFormattedPrice(for: coinObject.low_24h))
                        getRow(with: "Price Change:", value: getFormattedPrice(for: coinObject.price_change_24h))
                        getRow(with: "Market Cap:", value: "\(coinObject.market_cap ?? 0)")
                    }
                    .padding(20)
                }
            }
    }
    
    func getRow(with title: String, value: String) -> some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.title3)
            Spacer()
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
    
    func getFormattedPrice(for price: Double?) -> String {
        "$"+FormattedPrice(wrappedValue: "\(price ?? 0.0)").wrappedValue
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
