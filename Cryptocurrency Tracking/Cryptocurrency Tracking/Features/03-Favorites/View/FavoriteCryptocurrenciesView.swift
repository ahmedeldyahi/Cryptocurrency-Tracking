//
//  FavoriteCryptocurrenciesView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import SwiftUI

//struct FavoriteCryptocurrenciesView: View {
//    @StateObject var viewModel = FavoritesViewModel()
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                if viewModel.cryptocurrencies.filter(\.isFavorite).isEmpty {
//                    Text("No favorites added.")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    List(viewModel.cryptocurrencies.filter(\.isFavorite)) { crypto in
//                        HStack {
//                            VStack(alignment: .leading, spacing: 4) {
//                                Text(crypto.name)
//                                    .font(.headline)
//                                Text(crypto.symbol.uppercased())
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                            }
//                            Spacer()
////                            Text(String(format: "$%.2f", crypto.price))
////                                .font(.headline)
//
//                            Button(action: {
//                                viewModel.toggleFavorite(id: crypto.id)
//                            }) {
//                                Image(systemName: "star.fill")
//                                    .foregroundColor(.yellow)
//                            }
//                            .buttonStyle(BorderlessButtonStyle())
//                        }
//                        .padding(.vertical, 8)
//                    }
//                }
//            }
//            .navigationTitle("Favorites")
//        }
//    }
//}
//#Preview {
//    FavoriteCryptocurrenciesView()
//}
