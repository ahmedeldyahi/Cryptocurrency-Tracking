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
    private var timerCancellable: AnyCancellable?

    override init(fetchUseCase: FetchPricesUseCase = FetchPricesUseCaseImpl()) {
        super.init(fetchUseCase: fetchUseCase)
        startAutoRefresh()
    }

    private func startAutoRefresh() {
        timerCancellable = Timer.publish(every: 30.0, on: .main, in: .common)
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


