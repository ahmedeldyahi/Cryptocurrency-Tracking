//
//  CryptoRepository.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine

protocol CryptoRepository {
    func fetchCryptocurrencies(query: String) -> AnyPublisher<[Cryptocurrency], Error>
    func fetchMarketPrices() -> AnyPublisher<[Cryptocurrency], Error>
    func fetchCryptoDetails(id: String) -> AnyPublisher<CryptocurrencyDetails, Error>
}
