//
//  CryptoListView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 25/12/2024.
//

import Foundation
import SwiftUI

struct CryptoListView<Content: View>: View {
    let state: VieState<[Cryptocurrency]>
    let lastUpdate: Date?
    let listContent: ([Cryptocurrency]) -> Content
    let withSearch: Bool = false
    let onRetry: () -> Void
    
    
    var body: some View {
        switch state {
        case .idle:
            Text("Start searching for cryptocurrencies.")
                .foregroundColor(.gray)
        case .loading:
            LoadingView()
        case .success(let cryptos):
            VStack {
                if let lastUpdate = lastUpdate {
                    HStack {
                        Text("Last Update:")
                        Text(lastUpdate, style: .relative)
                        Text(" ago")
                    }
                    .font(.headline)
                    .foregroundColor(Color.theme.green)
                    .padding()
                }
                listContent(cryptos)
            }
        case .error(let errorMessage):
            ErrorView(heading: errorMessage)
        }
    }
}
