//
//  NetworkManager.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation
import Combine

final class NetworkManager: NetworkService {
    func fetch<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, Error> {
        guard let urlRequest = endpoint.urlRequest else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
