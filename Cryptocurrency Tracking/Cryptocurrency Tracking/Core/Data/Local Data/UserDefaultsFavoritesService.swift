//
//  UserDefaultsFavoritesService.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 22/12/2024.
//

import Foundation

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

protocol LocalDatabaseService {
    func toggleFavorite(crypto:  Cryptocurrency)
    func isFavorite(crypto: Cryptocurrency) -> Bool
    func fetchAllFavorites() -> [CryptocurrencyEntity]
}

import CoreData

final class CoreDataService: LocalDatabaseService {
    
    static let shared = CoreDataService() // Singleton instance
    private let container: NSPersistentContainer
    private let notifier: Notifier
    private init(notifier: Notifier = CryptoNotifier()) {
        self.notifier = notifier
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data stack initialization failed: \(error)")
            }
        }
    }
    
    private var context: NSManagedObjectContext {
        container.viewContext
    }
    
    // Toggle favorite status
    func toggleFavorite(crypto: Cryptocurrency) {
        var favorite: Bool
        if let existing = fetchFavorite(symbol: crypto.symbol) {
            context.delete(existing)
            favorite = false
        } else {
            let entity = CryptocurrencyEntity(context: context)
            entity.symbol = crypto.symbol
            entity.dailyChange = crypto.dailyChange
            entity.price = crypto.price
            entity.time = crypto.time
            entity.ts = crypto.ts
            favorite  = true
        }
        saveContext()
        notifier.postNotification(crypto: (crypto.symbol, favorite))
    }
    
    // Check if a cryptocurrency is a favorite
    func isFavorite(crypto: Cryptocurrency) -> Bool {
        fetchFavorite(symbol: crypto.symbol) != nil
    }
    
    func fetchAllFavorites() -> [CryptocurrencyEntity] {
        let request: NSFetchRequest<CryptocurrencyEntity> = CryptocurrencyEntity.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    // MARK: - Private Helpers
    
    private func fetchFavorite(symbol: String) -> CryptocurrencyEntity? {
        let request: NSFetchRequest<CryptocurrencyEntity> = CryptocurrencyEntity.fetchRequest()
        request.predicate = NSPredicate(format: "symbol == %@", symbol)
        return (try? context.fetch(request))?.first
    }

    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Failed to save Core Data context: \(error)")
            }
        }
    }
}


extension CryptocurrencyEntity {
  
    func toEntity() -> Cryptocurrency {
        Cryptocurrency(symbol: self.symbol ?? "", price: self.price ?? "", time: self.time, dailyChange: self.dailyChange ?? "", ts: self.ts, isFavorite: true)
    }
    
}

