//
//  CryptoDetailsView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 22/12/2024.
//

import SwiftUI

struct CryptoDetailsView: View {
    @ObservedObject var viewModel: CryptoDetailsViewModel
    
    var body: some View {
        Group {
            if let details = viewModel.cryptocurrencyDetails {
                VStack(alignment: .leading, spacing: 16) {
                    Text(details.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(details.symbol)
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text("Current Price:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(String(format: "$%.2f", details.currentPrice))
                            .font(.title2)
                    }
                    
                    HStack {
                        Text("Price Change (24h):")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(String(format: "%.2f%%", details.priceChangePercentage))
                            .font(.title2)
                            .foregroundColor(details.priceChangePercentage >= 0 ? .green : .red)
                    }
                    
                    Spacer()
                }
                .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .font(.headline)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ProgressView("Loading details...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
        }
        .navigationTitle("Details")
    }
}
//#Preview {
//    CryptoDetailsView()
//}
