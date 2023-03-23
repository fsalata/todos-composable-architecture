//
//  TodoApp.swift
//  Todo
//
//  Created by Fabio Salata on 23/03/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TodoApp: App {
    let store = Store(initialState: TodosState(),
                      reducer: todosReducer,
                      environment: TodosEnvironment(uuid: UUID.init, scheduler: .main))

    var body: some Scene {
        WindowGroup {
            TodosView(store: store)
        }
    }
}
