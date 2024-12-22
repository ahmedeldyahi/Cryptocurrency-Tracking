//
//  FavoritesService.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation

protocol FavoritesService {
    func isFavorite(id: String) -> Bool
    func addFavorite(id: String)
    func removeFavorite(id: String)
    func fetchFavorites() -> [String]
}

final class UserDefaultsFavoritesService: FavoritesService {
    private let favoritesKey = "favoriteCryptocurrencies"
    private let defaults = UserDefaults.standard
    
    func isFavorite(id: String) -> Bool {
        let favorites = fetchFavorites()
        return favorites.contains(id)
    }
    
    func addFavorite(id: String) {
        var favorites = fetchFavorites()
        guard !favorites.contains(id) else { return }
        favorites.append(id)
        defaults.set(favorites, forKey: favoritesKey)
    }
    
    func removeFavorite(id: String) {
        var favorites = fetchFavorites()
        favorites.removeAll { $0 == id }
        defaults.set(favorites, forKey: favoritesKey)
    }
    
    func fetchFavorites() -> [String] {
        defaults.array(forKey: favoritesKey) as? [String] ?? []
    }
}
