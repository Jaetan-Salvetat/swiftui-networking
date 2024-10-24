//
//  TodoApiImp.swift
//  Networking
//
//  Created by Gaetan Salvi on 24/10/2024.
//

protocol TodoApi {
    static func getTodos() async throws -> [Todo]
}
