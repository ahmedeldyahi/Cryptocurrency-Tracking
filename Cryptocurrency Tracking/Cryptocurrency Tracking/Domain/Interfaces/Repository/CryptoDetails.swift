//
//  CryptoDetails.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 27/12/2024.
//

import Foundation

typealias DetailRepository = Repository & CryptoDetails

protocol CryptoDetails {
    func fetchCryptoDetails(id: String) async -> Result<TickerModel, AppError>
}
