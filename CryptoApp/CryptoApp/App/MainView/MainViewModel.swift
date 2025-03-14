//
//  MainViewModel.swift
//  CryptoApp
//
//  Created Gabriel Alejandro Briseño Alvarez on 13/03/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//

import Foundation

protocol MainViewModelProtocol {
    var contentUnavailableData: (title: String, icon: String, description: String) { get }
    var cryptocoins: [CoinObject] { get set }
    var filteredResults: [CoinObject] { get }
    var isLoading: Bool { get }
    var shouldShowContentUnavailable: Bool { get }
    var title: String { get }

    func filter(for text: String)
    func getColumns(for size: CGSize) -> Int
    func getDarkControlIcon(for state: Bool) -> String
    func refreshData()
}

@Observable
class MainViewModel: MainViewModelProtocol {
    private(set) var contentUnavailableData = (title: "Ooops, something went wrong", icon: "flame", description: "Looks like there is no data to be displayed")
    private(set) var filteredResults: [CoinObject] = []
    private(set) var isLoading: Bool = true
    private(set) var shouldShowContentUnavailable: Bool = false
    private(set) var title: String
    
    var cryptocoins: [CoinObject]
    
    init(title: String = "CryptoApp", cryptocoins: [CoinObject] = []) {
        self.title = title
        self.cryptocoins = cryptocoins
        
        if cryptocoins.isEmpty {
            refreshData()
        }
    }
    
    func filter(for text: String) {
        filteredResults = cryptocoins.filter { coin in
            coin.name?.hasPrefix(text) ?? false
        }
    }

    func getColumns(for size: CGSize) -> Int {
        size.width > size.height ? 4 : 2
    }

    func getDarkControlIcon(for isActivated: Bool) -> String {
        isActivated ? "sun.max.fill" : "moon.stars.fill"
    }
    
    func refreshData() {
        shouldShowContentUnavailable = false
        isLoading = true

        // 🚨 I'm fetching data after some secs in order to put my shimmer effect in action
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            NetworkManager.shared.fetchData(for: NetworkManager.Endpoint.mainPage(20).getURL()) { [weak self] (result: Result<[CoinObject], Error>) in
                self?.isLoading = false

                switch result {
                case .success(let data):
                    self?.cryptocoins = data
                case .failure(let error):
                    print("Unexpected error: ", error.localizedDescription)
                    self?.cryptocoins = []
                    self?.shouldShowContentUnavailable = true
                }
            }
        }
    }
}
