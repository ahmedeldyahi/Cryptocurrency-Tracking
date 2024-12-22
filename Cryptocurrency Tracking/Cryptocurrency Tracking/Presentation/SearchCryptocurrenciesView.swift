//
//  SearchCryptocurrenciesView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import SwiftUI

struct SearchCryptocurrenciesView: View {
    @StateObject var viewModel = CryptoSearchViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search cryptocurrencies", text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                // List of Cryptocurrencies
                List {
                    ForEach(viewModel.cryptocurrencies, id: \.id) { crypto in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(crypto.name)
                                    .font(.headline)
                                Text(crypto.symbol.uppercased())
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(String(format: "$%.2f", 100))
                                .font(.headline)
                            
                            Button(action: {
                                viewModel.toggleFavorite(id: crypto.id)
                            }) {
                                Image(systemName: crypto.isFavorite ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Cryptocurrencies")
        }
    }
}

#Preview {
    SearchCryptocurrenciesView(viewModel: CryptoSearchViewModel())
}
