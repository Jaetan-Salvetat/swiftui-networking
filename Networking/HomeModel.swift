//
//  HomeModel.swift
//  Networking
//
//  Created by Gaetan Salvi on 18/10/2024.
//

import SwiftUI

@Observable
class HomeModel {
    var todos: [Todo] = []
    
    /// Get all todos
    func fetchTodos() async {
        do {
            todos = try await TodoApiImpl.getTodos()
        } catch {
            // handle error
        }
    }
    
    /// Delete one todo
    func deleteTodo(todoId: Int) async {
        do {
            try await TodoApiImpl.deleteTodo(todoId: todoId)
            todos.removeAll {
                $0.id == todoId
            }
        } catch {
            // handle error
        }
    }
}

struct Todo: Codable, Identifiable {
    let id: Int
    let title: String
    let completed: Bool
    
    init(id: Int, title: String, completed: Bool = false) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}
