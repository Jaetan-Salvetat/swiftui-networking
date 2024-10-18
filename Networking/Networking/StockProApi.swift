//
//  StockProApi.swift
//  Networking
//
//  Created by Gaetan Salvi on 18/10/2024.
//

import Foundation

class StockProApi {
    static let shared = StockProApi()
    
    func makeRequest<T: Codable>(
        url: URL?,
        method: RequestMethod,
        body: Encodable? = nil
    ) async throws -> T {
        guard let requestUrl = url else {
            throw BackendError.badRequest
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        request.httpMethod = method.rawValue
        
        if let requestBody = body {
            do {
                request.httpBody = try JSONEncoder().encode(requestBody)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw BackendError.badRequest
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Handle errors
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw BackendError(rawValue: "backend error") ?? .unknown
        }
    }
}

enum RequestMethod: String {
    case get
    case post
    case put
    case delete
}
