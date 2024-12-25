//
//  FavoritesViewModel.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Combine
import Foundation

//final class FavoritesViewModel: ObservableObject {
//    @Published var favoriteCryptocurrencies: [CryptocurrencyViewModel] = []
//    @Published var errorMessage: String?
//
//    private let favoritesService: FavoritesService
//    private let fetchCryptocurrenciesUseCase: FetchCryptocurrenciesUseCase
//    private var cancellables = Set<AnyCancellable>()
//
//    init(favoritesService: FavoritesService, fetchCryptocurrenciesUseCase: FetchCryptocurrenciesUseCase) {
//        self.favoritesService = favoritesService
//        self.fetchCryptocurrenciesUseCase = fetchCryptocurrenciesUseCase
//        loadFavorites()
//    }
//
//    /// Fetch favorite cryptocurrencies based on saved IDs
//    func loadFavorites() {
//        let favoriteIds = favoritesService.fetchFavorites()
//
//        if favoriteIds.isEmpty {
//            self.favoriteCryptocurrencies = []
//            return
//        }
//
//        Publishers.MergeMany(favoriteIds.map { id in
//            fetchCryptocurrenciesUseCase.execute(query: id)
//        })
//        .collect() // Collect all publishers into an array
//        .map { responses in
//            responses.flatMap { $0 } // Flatten arrays of `Cryptocurrency`
//                .map { crypto in
//                    CryptocurrencyViewModel(
//                        isFavorite: true, 
//                        crypto: crypto
//                    )
//                }
//        }
//        .receive(on: DispatchQueue.main)
//        .sink(receiveCompletion: { completion in
//            if case .failure(let error) = completion {
//                self.errorMessage = error.localizedDescription
//            }
//        }, receiveValue: { favorites in
//            self.favoriteCryptocurrencies = favorites
//        })
//        .store(in: &cancellables)
//    }
//
//    /// Remove a cryptocurrency from favorites
//    func removeFavorite(id: String) {
//        favoritesService.removeFavorite(id: id)
//        loadFavorites() // Refresh the list after removing
//    }
//}
