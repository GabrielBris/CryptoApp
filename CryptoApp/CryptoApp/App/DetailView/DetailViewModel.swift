//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created Gabriel Alejandro Briseño Alvarez on 13/03/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//

import Foundation

protocol DetailViewViewModelProtocol {
    var plots: [PlotObject] { get }
}

@Observable
class DetailViewModel: DetailViewViewModelProtocol {
    var plots: [PlotObject]
    
    init(plots: [PlotObject] = []) {
        self.plots = plots
        
        if plots.isEmpty {
            self.plots = [
                PlotObject(x: "Quarter 1", y: 64),
                PlotObject(x: "Quarter 2", y: 35),
                PlotObject(x: "Quarter 3", y: 42),
                PlotObject(x: "Quarter 4", y: 81)
            ]
        }
    }
}
