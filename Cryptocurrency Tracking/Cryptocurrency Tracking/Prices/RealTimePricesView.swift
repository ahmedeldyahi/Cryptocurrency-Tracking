//
//  RealTimePricesView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import SwiftUI

struct RealTimePricesView: View {
    @StateObject var viewModel = RealTimePricesViewModel(fetchMarketPricesUseCase: FetchMarketPricesUseCaseImpl(repository: CryptoRepositoryImpl()))

    var body: some View {
        NavigationStack {
            List(viewModel.cryptocurrencies) { crypto in
                NavigationLink(destination: CryptoDetailsView(viewModel: CryptoDetailsViewModel(fetchCryptoDetailsUseCase: FetchCryptoDetailsUseCaseImpl(), cryptoID: crypto.id))) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(crypto.name)
                                .font(.headline)
                            Text(crypto.symbol.uppercased())
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(String(format: "$%.2f", crypto.price))
                            .font(.headline)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Real-Time Prices")
        }
    }
}

#Preview {
    RealTimePricesView()
}
