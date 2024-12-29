//
//  VieState.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 24/12/2024.
//

import Foundation

enum VieState<T: Equatable>: Equatable {
    case error(String)
    case loading
    case idle
    case success(T)
    
    static func == (lhs: VieState<T>, rhs: VieState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.error(let lhsMessage), .error(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.loading, .loading):
            return true
        case (.idle, .idle):
            return true
        case (.success(let lhsData), .success(let rhsData)):
            return lhsData == rhsData
        default:
            return false
        }
    }
}
