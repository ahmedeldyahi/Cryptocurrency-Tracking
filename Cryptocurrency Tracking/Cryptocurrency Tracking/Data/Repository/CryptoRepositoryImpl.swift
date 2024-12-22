//
//  CryptoRepositoryImpl.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine
final class CryptoRepositoryImpl: CryptoRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    func fetchCryptocurrencies(query: String) -> AnyPublisher<[Cryptocurrency], Error> {
        let endpoint = APIEndpoint(path: "/search", method: .GET, queryItems: [URLQueryItem(name: "query", value: query)])
        return networkService.fetch(endpoint: endpoint)
            .map { (response: SearchResponse) in response.coins }
            .eraseToAnyPublisher()
    }
    
    func fetchMarketPrices() -> AnyPublisher<[Cryptocurrency], Error> {
        let endpoint = APIEndpoint(path: "/coins/markets", method: .GET, queryItems: [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "50"), // Fetch top 50 coins
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "false")
        ])
        return networkService.fetch(endpoint: endpoint)
    }
    
    func fetchCryptoDetails(id: String) -> AnyPublisher<CryptocurrencyDetails, Error> {
        let endpoint = APIEndpoint(path: "/coins/\(id)", method: .GET, queryItems: nil)
        return networkService.fetch(endpoint: endpoint)
    }
}
