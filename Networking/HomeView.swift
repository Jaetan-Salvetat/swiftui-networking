//
//  HomeView.swift
//  Networking
//
//  Created by Gaetan Salvi on 18/10/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var model = HomeModel()
    
    var body: some View {
        List(model.todos) { todo in
            Text(todo.title)
        }
        .task {
            await model.fetchTodos()
        }
    }
}

#Preview {
    HomeView()
}
