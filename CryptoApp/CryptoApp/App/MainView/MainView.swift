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

    @State private var isDarkModeActivated = false
    @State private var searchableText: String = ""

    var body: some View {
        if viewModel.cryptocoins.isEmpty {
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
        } else {
            NavigationStack {
                GeometryReader { geometry in
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: viewModel.getColumns(for: geometry.size))
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.cryptocoins) { coin in
                                NavigationLink(destination: DetailView()) {
                                    Text(coin.name ?? "")
                                        .frame(minWidth: 150, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
                                        .background(Color.green)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .refreshable {
                        viewModel.refreshData()
                    }
                    .searchable(text: $searchableText) {
                        
                    }
                    .onChange(of: searchableText) { oldValue, newValue in
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button { isDarkModeActivated.toggle()
                            } label: { darkControl() }
                        }
                    }
                    .navigationTitle(viewModel.title)
                }
            }
        }
    }
}

private extension MainView {
    func darkControl() -> some View {
        Image(systemName: viewModel.getDarkControlIcon(for: isDarkModeActivated))
            .font(.system(size: 30))
            .padding()
            .foregroundStyle(.yellow)
            .rotationEffect(.degrees(isDarkModeActivated ? 360 : 0))
            .animation(.easeInOut(duration: 0.5), value: isDarkModeActivated)
    }
}

#Preview {
    MainView()
}
