//
//  BaseViewModel.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 25/12/2024.
//
import Combine
import Foundation

protocol BaseViewModel: ObservableObject {
    associatedtype Model
    var state: VieState<[Model]> { get set }
    func fetchData()
}

extension BaseViewModel {
    func handleSuccess(_ cryptos: [Model]) {
        DispatchQueue.main.async {
            self.state = .success(cryptos)
        }
    }

    func handleError(_ error: AppError) {
        DispatchQueue.main.async {
            self.state = .error(error.errorDescription)
        }
    }
}


class BaseCryptoViewModel: BaseViewModel {
    typealias Model = Cryptocurrency
    @Published var state: VieState<[Model]> = .idle
    private let fetchUseCase: FetchPricesUseCase
    private var cancellables = Set<AnyCancellable>()

    init(fetchUseCase: FetchPricesUseCase = FetchPricesUseCaseImpl()) {
        self.fetchUseCase = fetchUseCase
        fetchData()
    }

    func fetchData() {
        state = .loading
        Task {
            do {
                let cryptos = try await fetchUseCase.execute()
                handleSuccess(cryptos)
            } catch let err as AppError {
                handleError(err)
            }
        }
    }
    
    func handleSuccess(_ cryptos: [Model]) {
        DispatchQueue.main.async {
            self.state = .success(cryptos)
        }
    }

    func handleError(_ error: AppError) {
        DispatchQueue.main.async {
            self.state = .error(error.errorDescription)
        }
    }
}
