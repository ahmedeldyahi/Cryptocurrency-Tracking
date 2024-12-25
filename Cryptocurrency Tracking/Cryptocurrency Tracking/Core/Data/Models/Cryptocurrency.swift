//
//  Cryptocurrency.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

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

struct Description: Codable {
    let en: String?
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



struct PriceResponse: Decodable {
    let data: [Cryptocurrency]
}

struct Cryptocurrency: Decodable, Hashable {
    var symbol: String //symbol name
    var price: String //current price
    var time: UInt64 //time the record was created
    var dailyChange: String //dayli change in decimal
    var ts: UInt64 //time the record was published
    
    var formattedDailyChange: String {
        Formatter.shared.formattTwoDecimalsPercent(number: Double(dailyChange) ?? 0)
    }
    
    var formattedPrice: String {
        Formatter.shared.formatToNumberOfdigits(of: Double(price) ?? 0, maxNumberOfDigits: 9)
    }
}

