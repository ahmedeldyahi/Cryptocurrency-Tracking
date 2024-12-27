//
//  MockFetchDetailUseCase.swift
//  Cryptocurrency TrackingTests
//
//  Created by Ahmed Eldyahi on 27/12/2024.
//

import Foundation
import Combine
@testable import Cryptocurrency_Tracking

class MockFetchDetailUseCase: FetchDetailUseCase {
    var result: Result<TickerModel, AppError>!
    
    func execute(id: String) async throws -> TickerModel {
        switch result {
        case .success(let detail):
            return detail
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result not set")
        }
    }
}
