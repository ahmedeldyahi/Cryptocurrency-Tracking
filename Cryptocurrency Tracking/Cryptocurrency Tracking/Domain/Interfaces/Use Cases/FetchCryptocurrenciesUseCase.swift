//
//  FetchCryptocurrenciesUseCase.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine
protocol FetchCryptocurrenciesUseCase {
    func execute(query: String) -> AnyPublisher<[Cryptocurrency], Error>
}

protocol FetchMarketPricesUseCase {
    func execute() -> AnyPublisher<[Cryptocurrency], Error>
}

protocol FetchCryptoDetailsUseCase {
    func execute(id: String) -> AnyPublisher<CryptocurrencyDetails, Error>
}


final class FetchCryptocurrenciesUseCaseImpl: FetchCryptocurrenciesUseCase {
    private let repository: CryptoRepository
    
    init(repository: CryptoRepository = CryptoRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(query: String) -> AnyPublisher<[Cryptocurrency], Error> {
        repository.fetchCryptocurrencies(query: query)
    }
}

final class FetchMarketPricesUseCaseImpl: FetchMarketPricesUseCase {
    private let repository: CryptoRepository
    
    init(repository: CryptoRepository = CryptoRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Cryptocurrency], Error> {
        repository.fetchMarketPrices()
    }
}

final class FetchCryptoDetailsUseCaseImpl: FetchCryptoDetailsUseCase {
    private let repository: CryptoRepository
    
    init(repository: CryptoRepository = CryptoRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(id: String) -> AnyPublisher<CryptocurrencyDetails, Error> {
        repository.fetchCryptoDetails(id: id)
    }
}
