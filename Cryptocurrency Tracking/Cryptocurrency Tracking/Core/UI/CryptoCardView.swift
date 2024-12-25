//
//  ItemView.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 22/12/2024.
//

import SwiftUI

import SwiftUI
//import RealmSwift

struct CryptoCardView: View {
    let crypto: Cryptocurrency
    let onTap: () -> Void
    @State private var isFavorite = false
    
//    private let realmManager = RealmManager()

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.white.shadow(.drop(color: Color.theme.accent.opacity(0.2), radius: 2)))
            .frame(height: 80)
            .overlay {
                item
            }
            .onAppear {
//                isFavorite = realmManager.isFavorite(symbol: crypto.symbol)
            }
    }
    
    private var item: some View {
        HStack() {
            // Cryptocurrency symbol
            VStack(alignment: .leading) {
                Text(crypto.symbol)
                    .font(.body)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                Spacer()
                
                // Current price
                Text(crypto.formattedPrice)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
            }

            
            Spacer()
            
            // Daily change
            DailyChangeView(
                dailyChage: Double(crypto.dailyChange) ?? 0,
                dailyChangeFormatted: crypto.formattedDailyChange
            )
            
            // Favorite button
            favoriteButton
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
    
    private var favoriteButton: some View {
        Button(action: toggleFavorite) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .red : .gray)
                .scaleEffect(isFavorite ? 1.2 : 1.0)
                .animation(.easeInOut, value: isFavorite)
        }
        .buttonStyle(BorderlessButtonStyle()) 
    }
    
    private func toggleFavorite() {
        isFavorite.toggle()
//        if isFavorite {
//            realmManager.addToFavorites(crypto: crypto)
//        } else {
//            realmManager.removeFromFavorites(symbol: crypto.symbol)
//        }
    }
}

#Preview {
    CryptoCardView(crypto: CR1) {
        
    }.padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    
}

let CR1 = Cryptocurrency(symbol: "BTC_USDD", price: "99000", time: 1735078594260, dailyChange: "0.0465", ts: 1735078594273)
struct DailyChangeView: View {
    let dailyChage: Double
    let dailyChangeFormatted: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(dailyChage < 0 ? Color.theme.red : Color.theme.green)
            .frame(width: 72, height: 28)
            .overlay {
                Text(dailyChangeFormatted)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
    }
}

//struct DailyChangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyChangeView(
//            dailyChage: 23.4,
//            dailyChangeFormatted: "23.40%"
//        )
//    }
//}
