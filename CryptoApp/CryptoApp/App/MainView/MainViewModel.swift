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
    var cryptocoins: [CoinObject] { get }
    var title: String { get }
    var contentUnavailableData: (title: String, icon: String, description: String) { get }

    func getColumns(for size: CGSize) -> Int
    func getDarkControlIcon(for state: Bool) -> String
    func refreshData()
}

@Observable
class MainViewModel: MainViewModelProtocol {
    private(set) var cryptocoins: [CoinObject]
    private(set) var title: String
    private(set) var contentUnavailableData = (title: "Ooops, something went wrong", icon: "flame", description: "Looks like there is no data to be displayed")
    
    init(title: String = "CryptoApp", cryptocoins: [CoinObject] = []) {
        self.title = title
        self.cryptocoins = cryptocoins
        
        if cryptocoins.isEmpty {
            refreshData()
        }
    }
    
    func getColumns(for size: CGSize) -> Int {
        size.width > size.height ? 4 : 2
    }

    func getDarkControlIcon(for isActivated: Bool) -> String {
        isActivated ? "sun.max.fill" : "moon.stars.fill"
    }
    
    func refreshData() {
        NetworkManager.shared.fetchData(for: NetworkManager.Endpoint.mainPage(20).getURL()) { [weak self] (result: Result<[CoinObject], Error>) in
            switch result {
            case .success(let data):
                self?.cryptocoins = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
