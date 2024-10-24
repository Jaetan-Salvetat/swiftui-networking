//
//  TodoApi.swift
//  Networking
//
//  Created by Gaetan Salvi on 18/10/2024.
//

import Foundation

class TodoApi {
    static func getTodos() async throws -> [Todo] {
        return try await StockProApi.shared.makeRequest(
            url: URL(string: "https://jsonplaceholder.typicode.com/todos"),
            method: .get)
    }
}
