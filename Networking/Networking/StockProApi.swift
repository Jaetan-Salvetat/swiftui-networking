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
            throw AppError.badRequest
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        request.httpMethod = method.rawValue
        
        if let requestBody = body {
            do {
                request.httpBody = try JSONEncoder().encode(requestBody)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw AppError.custom(message: error.localizedDescription)
            }
        }
        
        do {
            var (data, response) = try await URLSession.shared.data(for: request)
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            // Unlog user
            if statusCode == 401 || statusCode == 403 {
                // TODO: Unlog user
                throw AppError.logout
            }
            
            let result = try JSONDecoder().decode(T.self, from: data)
            
            // if !result.success {
            //     throw AppError.backend(message: result.message)
            // }
            
            return result
        } catch {
            // Manage timout
            if error._code == NSURLErrorTimedOut ||
                error._code == NSURLErrorNetworkConnectionLost ||
                error._code == NSURLErrorNotConnectedToInternet {
                
                throw AppError.timeout
            } else {
                throw AppError.custom(message: error.localizedDescription)
            }
        }
    }
}

enum RequestMethod: String {
    case get
    case post
    case put
    case delete
}
