//
//  AppCoordinator.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 24/12/2024.
//

import Foundation
import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func showDetails(for crypto: Cryptocurrency) {
        navigationPath.append(crypto)
    }
}
