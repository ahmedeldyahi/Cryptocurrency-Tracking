//
//  NetworkService.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Combine

protocol NetworkService {
    func fetch<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, Error>
}
