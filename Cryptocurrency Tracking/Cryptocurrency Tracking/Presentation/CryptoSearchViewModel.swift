//
//  CryptoSearchViewModel.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine

final class CryptoSearchViewModel: ObservableObject {
    private let fetchCryptocurrenciesUseCase: FetchCryptocurrenciesUseCase
    private let favoritesService: FavoritesService
    private var cancellables = Set<AnyCancellable>()
    @Published var searchText = ""
    @Published var cryptocurrencies: [CryptocurrencyViewModel] = []
    @Published var errorMessage: String?

    init(fetchCryptocurrenciesUseCase: FetchCryptocurrenciesUseCase = FetchCryptocurrenciesUseCaseImpl(repository: CryptoRepositoryImpl(networkService: NetworkManager())) ,
         favoritesService: FavoritesService = UserDefaultsFavoritesService()) {
        self.fetchCryptocurrenciesUseCase = fetchCryptocurrenciesUseCase
        self.favoritesService = favoritesService
        setupSearchListener()
    }
    
    private func setupSearchListener() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // Wait 0.5 seconds
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self, !query.isEmpty else {
                    self?.cryptocurrencies = []
                    return
                }
                self.searchCryptocurrencies(query: query)
            }
            .store(in: &cancellables)
    }
    
    
    func searchCryptocurrencies(query: String) {
        fetchCryptocurrenciesUseCase.execute(query: query)
            .map { cryptocurrencies in
                cryptocurrencies.map { crypto in
                    let isFavorite = self.favoritesService.isFavorite(id: crypto.id)
                    return CryptocurrencyViewModel(isFavorite: isFavorite, crypto: crypto)
                }
            }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { cryptocurrencies in
                self.cryptocurrencies = cryptocurrencies
            })
            .store(in: &cancellables)
    }

    func toggleFavorite(id: String) {
        if favoritesService.isFavorite(id: id) {
            favoritesService.removeFavorite(id: id)
        } else {
            favoritesService.addFavorite(id: id)
        }
        // Update local data
        self.cryptocurrencies = cryptocurrencies.map {
            $0.id == id ? $0.copy(isFavorite: !($0.isFavorite)) : $0
        }
    }
}


struct CryptocurrencyViewModel: Identifiable {
    let id: String
    let name: String
    let symbol: String
    let isFavorite: Bool
    let price: Double
    private let crypto: Cryptocurrency
    init(isFavorite: Bool,crypto:Cryptocurrency) {
        self.crypto = crypto
        self.isFavorite = isFavorite
        self.id = crypto.id
        self.symbol = crypto.symbol
        self.name = crypto.name
        self.price = crypto.currentPrice ?? 0
    }
    
    
    func copy(isFavorite: Bool) -> CryptocurrencyViewModel {
        CryptocurrencyViewModel(isFavorite: isFavorite, crypto: crypto)
    }
}
