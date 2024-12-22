//
//  Cryptocurrency.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
struct Cryptocurrency: Decodable {
    let id: String
    let name: String
    let symbol: String
    let currentPrice: Double?
}

import Foundation

struct CryptocurrencyDetails: Codable {
    let id: String
    let symbol: String
    let name: String
    let marketData: MarketData
}

struct MarketData: Codable {
    let currentPrice: Price?
    let priceChangePercentage24H: Double?

//    enum CodingKeys: String, CodingKey {
//        case currentPrice = "current_price"
//        case priceChangePercentage24H = "price_change_percentage_24h"
//    }
}

struct Price: Codable {
    let usd: Double?

    enum CodingKeys: String, CodingKey {
        case usd
    }
}

struct SearchResponse: Decodable {
    let coins: [Cryptocurrency]
}
