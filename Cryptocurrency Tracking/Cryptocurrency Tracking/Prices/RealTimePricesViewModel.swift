//
//  RealTimePricesViewModel.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Combine
import Foundation

final class RealTimePricesViewModel: ObservableObject {
    @Published var cryptocurrencies: [CryptocurrencyViewModel] = []
    @Published var errorMessage: String?

    private let fetchMarketPricesUseCase: FetchMarketPricesUseCase
    private var cancellables = Set<AnyCancellable>()
    private var timerCancellable: AnyCancellable?

    init(fetchMarketPricesUseCase: FetchMarketPricesUseCase) {
        self.fetchMarketPricesUseCase = fetchMarketPricesUseCase
        fetchMarketData()
        startAutoRefresh()
    }

    deinit {
        stopAutoRefresh()
    }

    /// Fetch real-time market data
    func fetchMarketData() {
        fetchMarketPricesUseCase.execute()
            .map { cryptocurrencies in
                cryptocurrencies.map { crypto in
                    CryptocurrencyViewModel(isFavorite: false, crypto: crypto)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] data in
                self?.cryptocurrencies = data
            })
            .store(in: &cancellables)
    }

    /// Start auto-refresh every 30 seconds
    private func startAutoRefresh() {
        timerCancellable = Timer
            .publish(every: 30.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchMarketData()
            }
    }

    /// Stop auto-refresh
    private func stopAutoRefresh() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}
