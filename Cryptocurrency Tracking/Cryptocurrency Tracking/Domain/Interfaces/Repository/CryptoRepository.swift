//
//  CryptoRepository.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine

protocol Repository {
    var networkMonitor: NetworkMonitorContract {get}
    func checkInternetConnection() -> Bool
}

extension Repository {
    func checkInternetConnection() -> Bool {
         if !networkMonitor.isConnected {
            let offlineError = AppError.offline
             ErrorManager.shared.showError(offlineError.errorDescription)
            return false
        }
        return true
    }
}

protocol CryptoRepository: Repository {
    func search(for query: String) async -> Result<[Cryptocurrency], AppError>
    func fetchPrices() async -> Result<[Cryptocurrency], AppError>
    func fetchCryptoDetails(id: String) async ->Result<TickerModel, AppError>
}
