//
//  MainView.swift
//  CryptoApp
//
//  Created Gabriel Alejandro Briseño Alvarez on 13/03/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//

import SwiftUI

struct MainView: View {
    @State private var viewModel: MainViewModelProtocol = MainViewModel()
    @Environment(\.colorScheme) private var colorScheme

    @State private var isDarkModeActivated = false
    @State private var searchableText: String = ""
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .neumorphicDark() : .neumorphicLight()
    }

    var body: some View {
        if viewModel.shouldShowContentUnavailable {
            getContentUnavailableView()
                .background(backgroundColor)
        } else {
            NavigationStack {
                GeometryReader { geometry in
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: viewModel.getColumns(for: geometry.size))
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            if viewModel.isLoading {
                                getLoadingRows(for: geometry)
                            } else {
                                getRowView(sourceOfTruth: viewModel.cryptocoins)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .scrollDisabled(viewModel.isLoading)
                    .refreshable {
                        viewModel.refreshData()
                    }
                    .searchable(text: $searchableText) {
                        getRowView(sourceOfTruth: viewModel.filteredResults)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, 10)
                    }
                    .onChange(of: searchableText) { _, _ in
                        viewModel.filter(for: searchableText)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            getDarkControlView()
                        }
                    }
                    .navigationTitle(viewModel.title)
                }
                .background(backgroundColor)
            }
        }
    }
}

private extension MainView {
    func getDarkControlView() -> some View {
        Button {
            isDarkModeActivated.toggle()
        } label: {
            Image(systemName: viewModel.getDarkControlIcon(for: isDarkModeActivated))
                .font(.system(size: 30))
                .padding()
                .foregroundStyle(.yellow)
                .rotationEffect(.degrees(isDarkModeActivated ? 360 : 0))
                .animation(.easeInOut(duration: 0.5), value: isDarkModeActivated)
        }
        .preferredColorScheme(isDarkModeActivated ? .dark : .light)
    }
    
    func getRowView(sourceOfTruth: [CoinObject]) -> some View {
        ForEach(sourceOfTruth) { coin in
            NavigationLink(destination: DetailView()) {
                NeumorphicView()
                    .overlay {
                        CardView(currentPrice: "\(coin.current_price ?? 0.0)",
                                 date: coin.last_updated ?? "",
                                 icon: coin.image ?? "",
                                 name: coin.name ?? "",
                                 symbol: coin.symbol ?? "")
                    }
            }
        }
    }
    
    func getLoadingRows(for geometryProxy: GeometryProxy) -> some View {
        ForEach((1...20), id: \.self) { _ in
            ShimmerView(geometryProxy: geometryProxy)
        }
    }

    func getContentUnavailableView() -> some View {
        ContentUnavailableView(label: {
            Label(viewModel.contentUnavailableData.title,
                  systemImage: viewModel.contentUnavailableData.icon)
        }, description: {
            Text(viewModel.contentUnavailableData.description)
        }, actions: {
            Button {
                viewModel.refreshData()
            } label: {
                Text("Retry")
            }
        })
    }
}

#Preview {
    MainView()
}
