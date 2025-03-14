//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 13/03/25.
//
import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    enum Endpoint {
        case mainPage(Int)
        case search(String)
        
        func getURL() -> URL? {
            let url: URL?
            
            switch self {
            case .mainPage(let count):
                url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=\(count)&page=1")
            case .search(let query):
                url = URL(string: "https://api.coingecko.com/api/v3/search?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
            }
            
            return url
        }
    }
    
    enum CryptoError: Error {
        case emptyData
        case invalidURL
        case serverError
        case invalidResponse
    }
    
    func fetchData<G: Codable>(for url: URL?, completion: @escaping (Result<G, Error>) -> Void) {
        guard let url else { completion(.failure(CryptoError.invalidURL)); return }

        cancellables.removeAll()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw CryptoError.serverError
                }
                return data
            }
            .decode(type: G.self, decoder: JSONDecoder())
            .retry(3)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished:
                    print("Everything went ok")
                case .failure(let error):
                    completion(.failure(error))
                }
            } receiveValue: { data in
                if let _data = data as? (any Collection), _data.isEmpty {
                    completion(.failure(CryptoError.emptyData))
                } else {
                    completion(.success(data))
                }
            }
            .store(in: &cancellables)
    }
}
