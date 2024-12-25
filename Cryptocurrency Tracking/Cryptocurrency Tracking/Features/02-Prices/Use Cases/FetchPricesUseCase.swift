//
//  FetchCryptocurrenciesUseCase.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine



protocol FetchPricesUseCase {
    func execute() async throws -> [Cryptocurrency]
}

final class FetchPricesUseCaseImpl: FetchPricesUseCase {
    private let repository: CryptoRepository
    
    init(repository: CryptoRepository = CryptoRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() async throws -> [Cryptocurrency] {
        let result =  await repository.fetchPrices()
        switch result {
        case .success(let cryptos):
            return cryptos.sorted(by: { $0.price > $1.price })
        case .failure(let err):
            throw err
        }
    }
}

