//
//  CryptoRepositoryImpl.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine
final class CryptoRepositoryImpl: CryptoRepository {
    var networkMonitor: any NetworkMonitorContract
    private let networkService: NetworkService
    private let errorManager: ErrorManager

    init(
        networkService: NetworkService = NetworkManager(),
        networkMonitor: NetworkMonitorContract = NetworkMonitor.shared,
        errorManager: ErrorManager = .shared
    ) {
        self.networkService = networkService
        self.networkMonitor = networkMonitor
        self.errorManager = errorManager
    }

    func search(for query: String) async -> Result<[Cryptocurrency], AppError> {
        await fetch(endpoint: APIEndpoint.search(query))
    }

    func fetchPrices() async -> Result<[Cryptocurrency], AppError> {
        await fetch(endpoint: APIEndpoint.cryptocurrencies)
        
    }
    
    func fetchCryptoDetails(id: String) async -> Result<TickerModel, AppError> {
        await fetch(endpoint: APIEndpoint.detail(id))
    }
}

extension CryptoRepositoryImpl {
    private func fetch<T: Decodable>(endpoint: APIEndpoint) async -> Result<T, AppError> {
        guard checkInternetConnection() else {
            return .failure(.offline)
        }

        do {
            // Handle the optional case by unwrapping the result or throwing an error
            guard let result: T = try await networkService.fetch(endpoint: endpoint) else {
                return .failure(.decodingFailed) // Handle a nil response as a decoding failure
            }
            return .success(result)
        } catch let error as AppError {
            // Log and return known network errors
            logError(endpoint: endpoint, error: error)
            return .failure(error)
        } catch {
            // Catch and wrap unexpected errors
            let unknownError = AppError.unknown(message: error.localizedDescription)
            logError(endpoint: endpoint, error: unknownError)
            return .failure(unknownError)
        }
    }

    private func logError(endpoint: APIEndpoint, error: AppError) {
        print("Handled Network Error for \(endpoint.path): \(error.errorDescription)")
    }
}
