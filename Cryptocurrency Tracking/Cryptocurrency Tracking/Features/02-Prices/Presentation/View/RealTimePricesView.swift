//
//  RealTimePricesView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import SwiftUI

struct RealTimePricesView: View {
    @ObservedObject var viewModel: RealTimePricesViewModel
    @StateObject var coordinator: AppCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            CryptoListView(
                state: viewModel.state,
                lastUpdate: viewModel.lastUpdate,
                listContent: { cryptos in
                    List(cryptos, id: \.symbol) { crypto in
                        CryptoCardView(crypto: crypto) {
                            coordinator.showDetails(for: crypto)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Cryptos")
                },
                onRetry: { viewModel.fetchData() }
            )
        }
    }
}

#Preview {
    RealTimePricesView(viewModel: .init())
        .environmentObject(AppCoordinator())
}
