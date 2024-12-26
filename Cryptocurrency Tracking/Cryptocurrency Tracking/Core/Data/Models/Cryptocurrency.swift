//
//  Cryptocurrency.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
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

