//
//  CoinObject.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 13/03/25.
//
import Foundation

struct CoinObject: Codable, Identifiable {
    var id = UUID()
    let identifiable: String?
    let symbol: String?
    let name: String?
    let image: String?
    let current_price: Double?
    let market_cap: Int?
    let total_volume: Int?
    let high_24h: Double?
    let low_24h: Double?
    let price_change_24h: Double?
    let last_updated: String?
    
    enum CodingKeys: String, CodingKey, Codable {
        case identifiable = "id"
        case symbol
        case name
        case image
        case current_price
        case market_cap
        case total_volume
        case high_24h
        case low_24h
        case price_change_24h
        case last_updated
    }
}
