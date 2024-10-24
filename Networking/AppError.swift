//
//  AppError.swift
//  Networking
//
//  Created by Gaetan Salvi on 22/10/2024.
//

enum AppError: Error {
    case badRequest
    case timeout
    case backend(message: String)
    case unknown
    case logout
    case custom(message: String)
    
    var errorType: BackendError {
        switch self {
        case .backend(let message):
            return BackendError(rawValue: message) ?? .unknown
        default:
            return .unknown
        }
    }
}
