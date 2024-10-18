//
//  ApiError.swift
//  Networking
//
//  Created by Gaetan Salvi on 18/10/2024.
//

import Foundation

enum BackendError: String, LocalizedError, CaseIterable {
    case badRequest
    case unknown
    
    static func fromString(errorString: String) -> BackendError {
        if let error = self.allCases.first(where: { $0.rawValue == errorString }) {
            return error
        }
        
        return .unknown
    }
}
