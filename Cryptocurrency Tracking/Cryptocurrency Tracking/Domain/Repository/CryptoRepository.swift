//
//  CryptoRepository.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine

typealias CryptoRepository = Repository & CryptoRepositoryContract

protocol CryptoRepositoryContract {
    func fetchPrices() async -> Result<[Cryptocurrency], AppError>
}
