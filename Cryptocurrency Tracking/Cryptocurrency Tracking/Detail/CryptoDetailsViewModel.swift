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
    @Published var cryptocurrencyDetails: CryptocurrencyDetailsViewModel?
    @Published var errorMessage: String?

    private let fetchCryptoDetailsUseCase: FetchCryptoDetailsUseCase
    private let cryptoID: String
    private var cancellables = Set<AnyCancellable>()

    init(fetchCryptoDetailsUseCase: FetchCryptoDetailsUseCase, cryptoID: String) {
        self.fetchCryptoDetailsUseCase = fetchCryptoDetailsUseCase
        self.cryptoID = cryptoID
        fetchDetails()
    }

    private func fetchDetails() {
        fetchCryptoDetailsUseCase.execute(id: cryptoID)
            .map { details in
                CryptocurrencyDetailsViewModel(
                    id: details.id,
                    name: details.name,
                    symbol: details.symbol.uppercased(),
                    currentPrice: details.marketData.currentPrice?.usd ?? 0,
                    priceChangePercentage: details.marketData.priceChangePercentage24H ?? 0
                )
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] detailsViewModel in
                self?.cryptocurrencyDetails = detailsViewModel
            })
            .store(in: &cancellables)
    }
}

struct CryptocurrencyDetailsViewModel: Identifiable {
    let id: String
    let name: String
    let symbol: String
    let currentPrice: Double
    let priceChangePercentage: Double

    /// Utility to format the price change with appropriate sign and precision
    var formattedPriceChange: String {
        String(format: "%.2f%%", priceChangePercentage)
    }

    /// Utility to determine the color for price change
    var priceChangeColor: Color {
        priceChangePercentage >= 0 ? .green : .red
    }
}
