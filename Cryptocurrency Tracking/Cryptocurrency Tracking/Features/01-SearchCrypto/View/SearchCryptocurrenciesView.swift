//
//  SearchCryptocurrenciesView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import SwiftUI

struct SearchCryptocurrenciesView: View {
    @ObservedObject var viewModel: CryptoSearchViewModel
    @StateObject var coordinator: AppCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            CryptoListView(
                viewModel: viewModel,
                state: viewModel.state,
                lastUpdate: nil,
                listContent: { cryptos in
                    List(cryptos, id: \.symbol) { crypto in
                        CryptoCardView(crypto: crypto) {
                            coordinator.showDetails(for: crypto)
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $viewModel.searchText)
                    .navigationTitle("Cryptos")
                },
                onRetry: { viewModel.fetchData()}
            )
            .navigationDestination(for: Cryptocurrency.self) { value in
                CryptoDetailsView(viewModel: .init(cryptoID: value.symbol))
            }
        }
    }
}
