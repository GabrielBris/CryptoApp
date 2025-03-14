//
//  CryptoAppTests.swift
//  CryptoAppTests
//
//  Created by Gabriel Alejandro Briseño Alvarez on 13/03/25.
//

import XCTest
@testable import CryptoApp

final class CryptoAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testEndpointURLs() {
        let mainPageURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1"
        XCTAssertEqual(URL(string: mainPageURL), NetworkManager.Endpoint.mainPage(20).getURL())
        
        let searchURL = "https://api.coingecko.com/api/v3/search?query="+"test%20one"
        XCTAssertEqual(URL(string: searchURL), NetworkManager.Endpoint.search("test one").getURL())
    }
    
    func testFetchDataReturnsInvalidURL() {
        let expectation = expectation(description: "Mock API Response - with invalid URL")
        let networkManager = MockNetworkManager(json: "")
        
        networkManager.fetchData(for: nil) { (result: Result<[CoinObject], Error>) in
            switch result {
            case .success(_):
                XCTFail("Unexpected succes since invalid url was sent to test edge case error")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkManager.CryptoError, NetworkManager.CryptoError.invalidURL)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchDataReturnsInvalidResponse() {
        let expectation = expectation(description: "Mock API Response - with invalid Response")
        let networkManager = MockNetworkManager(json: "")
        
        networkManager.fetchData(for: NetworkManager.Endpoint.mainPage(20).getURL()) { (result: Result<[CoinObject], Error>) in
            switch result {
            case .success(_):
                XCTFail("Unexpected succes since invalid response was sent to test edge case error")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkManager.CryptoError, NetworkManager.CryptoError.invalidResponse)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchDataReturnsEmptyData() {
        let expectation = expectation(description: "Mock API Response - with empty data")
        let networkManager = MockNetworkManager(json: "[]")
        
        networkManager.fetchData(for: NetworkManager.Endpoint.mainPage(20).getURL()) { (result: Result<[CoinObject], Error>) in
            switch result {
            case .success(_):
                XCTFail("Unexpected succes since empty data was sent to test edge case error")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkManager.CryptoError, NetworkManager.CryptoError.emptyData)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchDataReturnsValidData() {
        let expectation = expectation(description: "Mock API Response - with valid Response")
        let cryptoObject = """
        [
            {
                    "id": "bitcoin",
                    "symbol": "btc",
                    "name": "Bitcoin",
                    "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                    "current_price": 82960,
                    "market_cap": 1649439371104,
                    "market_cap_rank": 1,
                    "fully_diluted_valuation": 1649439371104,
                    "total_volume": 38511064146,
                    "high_24h": 84252,
                    "low_24h": 80833,
                    "price_change_24h": 1255.95,
                    "price_change_percentage_24h": 1.5372,
                    "market_cap_change_24h": 25660118007,
                    "market_cap_change_percentage_24h": 1.58027,
                    "circulating_supply": 19836118,
                    "total_supply": 19836118,
                    "max_supply": 21000000,
                    "ath": 108786,
                    "ath_change_percentage": -23.70644,
                    "ath_date": "2025-01-20T09:11:54.494Z",
                    "atl": 67.81,
                    "atl_change_percentage": 122297.24939,
                    "atl_date": "2013-07-06T00:00:00.000Z",
                    "roi": null,
                    "last_updated": "2025-03-13T06:30:07.826Z"
                }
        ]
        """
        let networkManager = MockNetworkManager(json: cryptoObject)
        
        networkManager.fetchData(for: NetworkManager.Endpoint.mainPage(20).getURL()) { (result: Result<[CoinObject], Error>) in
            switch result {
            case .success(let data):
                XCTAssertGreaterThan(data.count, 0)
                let firstCryptoObject = data.first
                XCTAssertEqual(firstCryptoObject?.identifiable, "bitcoin")
                XCTAssertEqual(firstCryptoObject?.symbol, "btc")
                XCTAssertEqual(firstCryptoObject?.name, "Bitcoin")
                XCTAssertEqual(firstCryptoObject?.image, "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")
                XCTAssertEqual(firstCryptoObject?.current_price, 82960)
                XCTAssertEqual(firstCryptoObject?.market_cap, 1649439371104)
                XCTAssertEqual(firstCryptoObject?.high_24h, 84252)
                XCTAssertEqual(firstCryptoObject?.low_24h, 80833)
                XCTAssertEqual(firstCryptoObject?.last_updated, "2025-03-13T06:30:07.826Z")
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected fail since valid data was sent to test.")
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchDataReturnsNilParameters() {
        let expectation = expectation(description: "Mock API Response - with nil parameters")
        let cryptoObject = """
        [
            {
                    "last_updated": "2025-03-13T06:30:07.826Z"
                }
        ]
        """
        let networkManager = MockNetworkManager(json: cryptoObject)
        
        networkManager.fetchData(for: NetworkManager.Endpoint.mainPage(20).getURL()) { (result: Result<[CoinObject], Error>) in
            switch result {
            case .success(let data):
                XCTAssertGreaterThan(data.count, 0)
                let firstCryptoObject = data.first
                XCTAssertNil(firstCryptoObject?.identifiable)
                XCTAssertNil(firstCryptoObject?.symbol)
                XCTAssertNil(firstCryptoObject?.name)
                XCTAssertNil(firstCryptoObject?.image)
                XCTAssertNil(firstCryptoObject?.current_price)
                XCTAssertNil(firstCryptoObject?.market_cap)
                XCTAssertNil(firstCryptoObject?.high_24h)
                XCTAssertNil(firstCryptoObject?.low_24h)
                XCTAssertEqual(firstCryptoObject?.last_updated, "2025-03-13T06:30:07.826Z")
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected fail since valid data was sent to test.")
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
