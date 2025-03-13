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
    @State private var searchableText: String = ""
    @State private var isDarkModeActivated = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(spacing: 20), GridItem(spacing: 20)], spacing: 20) {
                    ForEach(0...100, id: \.self) { row in
                        NavigationLink(destination: DetailView()) {
                            Text("lol")
                                .frame(minWidth: 150, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
                                .background(Color.green)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .refreshable {
                print("refreshing...")
            }
            .searchable(text: $searchableText) {
                
            }
            .onChange(of: searchableText) { oldValue, newValue in
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isDarkModeActivated.toggle()
                    } label: {
                        Image(systemName: isDarkModeActivated ? "sun.max.fill" : "moon.fill")
                            .font(.system(size: 30))
                            .padding()
                            .foregroundStyle(.yellow)
                            .rotationEffect(.degrees(isDarkModeActivated ? 360 : 0))
                            .animation(.easeInOut(duration: 0.5), value: isDarkModeActivated)
                    }

                }
            }
            .navigationTitle("Test")
        }
    }
}

#Preview {
    MainView()
}
