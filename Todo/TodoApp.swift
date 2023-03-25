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
    func createStore() -> Store<TodosState, TodosAction> {
        let cache = UserDefaultsCache(key: "todos")
        return .init(
            initialState: cache.load() ?? TodosState(),
            reducer: todosReducer.caching(
                cache: cache,
                ignoreCachingDuplicates: { $0.todos == $1.todos }
            ),
            environment: TodosEnvironment(
                uuid: UUID(), scheduler: .main
            )
        )
      }

    var body: some Scene {
        WindowGroup {
            TodosView(store: createStore())
        }
    }
}
