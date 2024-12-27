//
//  Cryptocurrency.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
struct Cryptocurrency: Decodable, Hashable {
    var symbol: String
    var price: String
    var time: Int64
    var dailyChange: String
    var ts: Int64
    var isFavorite: Bool? = false // Mark favorites
    
    mutating func updateisFavorite(with isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    var formattedDailyChange: String {
        Formatter.shared.formattTwoDecimalsPercent(number: Double(dailyChange) ?? 0)
    }
    
    var formattedPrice: String {
        Formatter.shared.formatToNumberOfdigits(of: Double(symbol) ?? 0, maxNumberOfDigits: 9)
    }
}

