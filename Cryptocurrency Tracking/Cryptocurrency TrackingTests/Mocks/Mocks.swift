//
//  Mocks.swift
//  Cryptocurrency TrackingTests
//
//  Created by Ahmed Eldyahi on 27/12/2024.
//

import XCTest
@testable import Cryptocurrency_Tracking

// MARK: - MOCKS

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        guard let data = mockData, let response = mockResponse else {
            throw AppError.unknown(message: "Mock response not set.")
        }
        return (data, response)
    }
}


struct TestModel: Codable, Equatable {
    let id: Int
    let name: String
}

struct MockAPIEndpoint: APIEndpointContract {
    var path: String = ""
    
    var queryItems: [URLQueryItem]?
    
    var urlRequest: URLRequest? {
        return URLRequest(url: URL(string: "https://example.com")!)
    }
}
