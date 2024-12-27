//
//  TickerModel.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 25/12/2024.
//

import Foundation

// MARK: - TickerModel
struct TickerModel: Codable,Equatable {
    let symbol, open, low, high: String
    let close, quantity, amount: String
    let tradeCount, startTime, closeTime: Int
    let displayName, dailyChange, bid, bidQuantity: String
    let ask, askQuantity: String
    let ts: Int
    let markPrice: String
}
