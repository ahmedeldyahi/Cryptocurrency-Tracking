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
