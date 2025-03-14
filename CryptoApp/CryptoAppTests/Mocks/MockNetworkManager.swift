//
//  MockNetworkManager.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 13/03/25.
//
import Foundation

class MockNetworkManager: NetworkManager {
    var json: String

    init(json: String) {
        self.json = json
    }

    override func fetchData<G: Codable>(for url: URL?, completion: @escaping (Result<G, Error>) -> Void) {
        guard let _ = url else {
            completion(.failure(NetworkManager.CryptoError.invalidURL))
            return
        }

        guard let data = json.data(using: .utf8) else {
            completion(.failure(NetworkManager.CryptoError.invalidResponse))
            return
        }

        do {
            let decodedData = try JSONDecoder().decode(G.self, from: data)
            
            if let collection = decodedData as? (any Collection), collection.isEmpty {
                completion(.failure(NetworkManager.CryptoError.emptyData))
            } else {
                completion(.success(decodedData))
            }

        } catch {
            completion(.failure(NetworkManager.CryptoError.invalidResponse))
        }
    }
}
