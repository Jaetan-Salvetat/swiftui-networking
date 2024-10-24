//
//  ApiError.swift
//  Networking
//
//  Created by Gaetan Salvi on 18/10/2024.
//

import Foundation

enum BackendError: String {
    case unknown
    
    var message: String {
        switch self {
        default:
            return "Unknown"
        }
    }
}
