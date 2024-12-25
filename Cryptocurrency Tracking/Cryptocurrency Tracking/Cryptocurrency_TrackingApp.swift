//
//  Cryptocurrency_TrackingApp.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import SwiftUI

@main
struct Cryptocurrency_TrackingApp: App {
    init() {
        _ = NetworkMonitor.shared
    }
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .globalErrorToast()
        }
    }
}
