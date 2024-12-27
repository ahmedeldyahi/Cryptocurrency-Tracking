//
//  CryptoDetailsRepositoryImpl.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 27/12/2024.
//

import Foundation

final class CryptoDetailsRepositoryImpl: DetailRepository {
    var networkMonitor: any NetworkMonitorContract
    internal let networkService: NetworkService
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
        
    
    func fetchCryptoDetails(id: String) async -> Result<TickerModel, AppError> {
        await fetch(endpoint: APIEndpoint.detail(id))
    }
}
