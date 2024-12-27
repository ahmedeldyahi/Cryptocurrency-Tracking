//
//  RealTimePricesViewModel.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Combine
import Foundation
class RealTimePricesViewModel: BaseCryptoViewModel {
    @Published var lastUpdate: Date = .now
    private(set) var timerCancellable: AnyCancellable?
    private var timerInterval: TimeInterval

    // Allowing a custom interval for testing
    init(fetchUseCase: FetchPricesUseCase = FetchPricesUseCaseImpl(), timerInterval: TimeInterval = 30.0) {
        self.timerInterval = timerInterval
        super.init(fetchUseCase: fetchUseCase)
        startAutoRefresh()
    }

    private func startAutoRefresh() {
        timerCancellable = Timer.publish(every: timerInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchData()
                self?.lastUpdate = .now
            }
    }

    deinit {
        timerCancellable?.cancel()
    }
}

