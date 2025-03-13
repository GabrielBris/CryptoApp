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
    var title: String { get }

    func getColumns(for size: CGSize) -> Int
    func getDarkControlIcon(for state: Bool) -> String
}

@Observable
class MainViewModel: MainViewModelProtocol {
    private(set) var title: String = "CryptoApp"
    
    func getColumns(for size: CGSize) -> Int {
        size.width > size.height ? 4 : 2
    }

    func getDarkControlIcon(for isActivated: Bool) -> String {
        isActivated ? "sun.max.fill" : "moon.fill"
    }
}
