//
//  MainTabView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import SwiftUI

struct MainTabView: View {    
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
    }
}

#Preview {
    MainTabView()
}
