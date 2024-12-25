//
//  NetworkManager.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine

final class NetworkManager: NetworkService {
    // Decode a response in a type-safe manner
    private func decode<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw AppError.decodingFailed
        }
    }
    
    // Main Fetch Method with async/await and Enhanced Error Handling
    func fetch<T: Decodable>(endpoint: APIEndpointContract) async throws -> T {
        guard let urlRequest = endpoint.urlRequest else {
            throw AppError.badURL
        }
        
        do {
            // Perform network call with async/await
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // Verify the HTTP response and handle errors
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AppError.unknown(message: "No HTTP URL response found.")
            }
            try httpResponse.checkErrors()
            
            // Decode the data into the specified type
            return try decode(data)
            
        } catch let error as AppError {
            // Handle and rethrow known network errors
            throw error
        } catch {
            // Handle unknown errors gracefully
            throw AppError.unknown(message: error.localizedDescription)
        }
    }
}
