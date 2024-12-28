//
//  FavoritesRepository.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 27/12/2024.
//

import Foundation

class FavoritesRepository: CryptoRepositoryContract {
    private let errorManager: ErrorManagerContract
    private let databaseService: LocalDatabaseService
    
    init(
        errorManager: ErrorManagerContract = ErrorManager.shared,
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
            return Result.success(cryptos)
        }
    }
}
