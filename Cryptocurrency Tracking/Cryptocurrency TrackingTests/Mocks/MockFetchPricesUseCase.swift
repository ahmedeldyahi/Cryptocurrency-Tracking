//
//  MockFetchPricesUseCase.swift
//  Cryptocurrency TrackingTests
//
//  Created by Ahmed Eldyahi on 27/12/2024.
//

import Foundation
import XCTest
import Combine
@testable import Cryptocurrency_Tracking
typealias MockResult = Result<[Cryptocurrency], AppError>

final class MockFetchPricesUseCase: FetchPricesUseCase {
    var result: Result<[Cryptocurrency], AppError>!
    
    func execute() async throws -> [Cryptocurrency] {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        case .none:
            fatalError("No result set in MockFetchPricesUseCase")
        }
    }
}

extension Notification.Name {
    static let CryptoChange = Notification.Name("CryptoChange")
}

let sampleCryptos: [Cryptocurrency] = [
    Cryptocurrency(symbol: "BTC", price: "10000", time: 12345, dailyChange: "0.05", ts: 67890, isFavorite: false),
    Cryptocurrency(symbol: "ETH", price: "5000", time: 54321, dailyChange: "0.02", ts: 98765, isFavorite: false),
]


let favoriteCryptos: [Cryptocurrency] = [
    Cryptocurrency(symbol: "BTC", price: "10000", time: 12345, dailyChange: "0.05", ts: 67890, isFavorite: true),
    Cryptocurrency(symbol: "ETH", price: "5000", time: 54321, dailyChange: "0.02", ts: 98765, isFavorite: false),
]


let filteredCryptos = sampleCryptos.filter { $0.symbol.contains("BTC") }
