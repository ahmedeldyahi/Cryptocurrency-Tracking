//
//  MainTabView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import SwiftUI

struct MainTabView: View {
    // Instantiate ViewModels
    //    private let searchViewModel: CryptoSearchViewModel
    //    private let realTimePricesViewModel: CryptoSearchViewModel // Reuse or create a new ViewModel
    //    private let favoritesViewModel: CryptoSearchViewModel
    //
    //    init(dependencyContainer: AppDependencyContainer) {
    //        self.searchViewModel = dependencyContainer.makeCryptoSearchViewModel()
    //        self.realTimePricesViewModel = dependencyContainer.makeCryptoSearchViewModel() // Mocked data or real use case
    //        self.favoritesViewModel = dependencyContainer.makeCryptoSearchViewModel()
    //    }
    
    @StateObject var coordinator: AppCoordinator = AppCoordinator()
    var body: some View {
        TabView {
            // Search Tab
            SearchCryptocurrenciesView(viewModel:.init())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            // Real-Time Prices Tab
            RealTimePricesView(viewModel:.init())
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Prices")
                }
            
            // Favorites Tab
            FavoriteCryptocurrenciesView(viewModel: .init())
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
        .accentColor(.blue) // Customize the TabBar highlight color
    }
}

#Preview {
    MainTabView()
}
