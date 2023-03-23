//
//  TodosView.swift
//  Todo
//
//  Created by Fabio Salata on 23/03/23.
//

import SwiftUI
import ComposableArchitecture

struct TodosView: View {
    let store: Store<TodosState, TodosAction>

    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                List {
                    ForEachStore(store.scope(state: \.todos, action: TodosAction.todo), content: TodoView.init)
                        .onDelete { viewStore.send(.delete($0)) }
                }
                .navigationTitle("Todos")
                .toolbar {
                    Button("Add Todo") { viewStore.send(.addTodo) }
                }
            }
        }
    }
}

struct TodosView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView(store: .init(
          initialState: .placeholder,
            reducer: todosReducer,
            environment: .init(uuid: UUID.init, scheduler: .main.eraseToAnyScheduler())
        ))
    }
}
