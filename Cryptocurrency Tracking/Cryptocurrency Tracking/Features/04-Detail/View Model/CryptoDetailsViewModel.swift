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

final class CryptoDetailsViewModel: BaseViewModel {
    typealias Model = TickerModel
    
    @Published var state: VieState<TickerModel> = .loading
    private let detailsUseCase: FetchDetailUseCase
    private let cryptoID: String
    
    init(
        detailsUseCase: FetchDetailUseCase = FetchDetailUseCaseImpl(),
        cryptoID: String
    ) {
        self.detailsUseCase = detailsUseCase
        self.cryptoID = cryptoID
        
        fetchData()
    }
    
    func fetchData() {
        Task {
            do {
                let detail = try await detailsUseCase.execute(id: cryptoID)
                handleSuccess(detail)
            } catch let err as AppError {
                handleError(err)
            }
        }
        
    }
}
