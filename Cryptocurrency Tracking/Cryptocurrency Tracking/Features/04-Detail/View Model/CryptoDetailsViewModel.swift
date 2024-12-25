//
//  CryptoDetailsViewModel.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 22/12/2024.
//

import Foundation
import Combine
import Foundation
import SwiftUI

final class CryptoDetailsViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var state: VieState<TickerModel> = .loading
    private let detailsUseCase: FetchDetailUseCase
    private let cryptoID: String
    
    init(
        detailsUseCase: FetchDetailUseCase = FetchDetailUseCaseImpl() ,
        cryptoID: String
    ) {
        self.detailsUseCase = detailsUseCase
        self.cryptoID = cryptoID
        
        fetchDetails()
    }
    
    private func fetchDetails() {
        Task {
            do {
                let detail = try await detailsUseCase.execute(id: cryptoID)
                await MainActor.run {
                    state = .success(detail)
                }
            } catch let err as AppError {
                await MainActor.run {
                    state = .error(err.errorDescription)
                }
            }
        }
    }
}
