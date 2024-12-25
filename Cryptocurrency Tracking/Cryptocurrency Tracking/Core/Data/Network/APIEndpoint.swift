//
//  APIEndpoint.swift
//  Cryptocurrency Tracking
//
//  Created by Ahmed Eldyahi on 21/12/2024.
//

import Foundation


protocol APIEndpointContract{
    var method: HTTPMethod {get}
    var path: String {get}
    
    var queryItems: [URLQueryItem]? {get}
}

var baseURL: URL {
    return URL(string: "https://api.poloniex.com/markets/")!
}

extension APIEndpointContract {
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.path + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    var method: HTTPMethod {
        .GET
    }
}


enum HTTPMethod: String {
    case GET, POST
}


enum APIEndpoint: APIEndpointContract {
    case cryptocurrencies
    case search(String)
    case detail(String)
    
    var path: String {
        return switch self {
        case .cryptocurrencies:
            "/price"
        case .search:
            "/search"
            
        case .detail(let id):
            "/\(id)/ticker24h"
        }
    }
    
    var queryItems: [URLQueryItem]? {return []}
    
}
