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
    private let databaseService: LocalDatabaseService
    
    init(
        networkService: NetworkService = NetworkManager(),
        networkMonitor: NetworkMonitorContract = NetworkMonitor.shared,
        errorManager: ErrorManager = .shared,
        databaseService: LocalDatabaseService = CoreDataService.shared
    ) {
        self.networkService = networkService
        self.networkMonitor = networkMonitor
        self.errorManager = errorManager
        self.databaseService = databaseService
    }
    
    func fetchPrices() async -> Result<[Cryptocurrency], AppError> {
        let result: Result<[Cryptocurrency], AppError> = await fetch(endpoint: APIEndpoint.cryptocurrencies)
        
        switch result {
        case .success(let cryptocurrencies):
            // Merge local favorites into the fetched list
            let updatedCryptocurrencies = mergeWithLocalFavorites(cryptocurrencies: cryptocurrencies)
            return .success(updatedCryptocurrencies)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func mergeWithLocalFavorites(cryptocurrencies: [Cryptocurrency]) -> [Cryptocurrency] {
        // Fetch all local favorites
        let favoriteSymbols = databaseService.fetchAllFavorites().map { $0.symbol }
        
        // Update the remote list based on local favorite symbols
        
        return cryptocurrencies.map { crypto in
            var updatedCrypto = crypto
            updatedCrypto.isFavorite = favoriteSymbols.contains(crypto.symbol)
            return updatedCrypto
        }
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
            guard let result: T = try await networkService.fetch(endpoint: endpoint) else {
                return .failure(.decodingFailed)
            }
            return .success(result)
        } catch let error as AppError {
            logError(endpoint: endpoint, error: error)
            return .failure(error)
        } catch {
            let unknownError = AppError.unknown(message: error.localizedDescription)
            logError(endpoint: endpoint, error: unknownError)
            return .failure(unknownError)
        }
    }
    
    private func logError(endpoint: APIEndpoint, error: AppError) {
        print("Handled Network Error for \(endpoint.path): \(error.errorDescription)")
    }
}

class FavoritesRepository: CryptoRepositoryContract {
    private let errorManager: ErrorManager
    private let databaseService: LocalDatabaseService
    
    init(
        errorManager: ErrorManager = .shared,
        databaseService: LocalDatabaseService = CoreDataService.shared
    ) {
        self.errorManager = errorManager
        self.databaseService = databaseService
    }
    
    func fetchPrices() async -> Result<[Cryptocurrency], AppError> {
        let cryptos = databaseService.fetchAllFavorites()
        if cryptos.isEmpty {
            return Result.failure(.empty)
        }else{
            return Result.success(cryptos.map {$0.toEntity()})
        }
    }
}
