//
//  NetworkService.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(endpoint: APIEndpointContract) async throws -> T? 
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
}
