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
                state: viewModel.state,
                lastUpdate: nil, retry: viewModel.fetchData,
                listContent: { cryptos in
                    List(cryptos, id: \.symbol) { crypto in
                        CryptoCardView(crypto: .constant(crypto)) {
                            coordinator.showDetails(for: crypto)
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $viewModel.searchText)
                    .navigationTitle("Cryptos")
                }
            )
            .navigationDestination(for: Cryptocurrency.self) { value in
                CryptoDetailsView(viewModel: .init(cryptoID: value.symbol))
            }
        }
    }
}
