//
//  TodosReducer.swift
//  Todo
//
//  Created by Fabio Salata on 23/03/23.
//

import Foundation
import ComposableArchitecture

struct TodosEnvironment {
    var uuid: UUID
    var scheduler: AnySchedulerOf<DispatchQueue>
}

enum TodosAction: Equatable {
    case addTodo
    case delete(IndexSet)
    case sortCompletedTodos
    case todo(id: Todo.ID, action: TodoAction)
}

let todosReducer = AnyReducer<TodosState, TodosAction, TodosEnvironment>.combine(
        todoReducer.forEach(state: \.todos, action: /TodosAction.todo, environment: { _ in TodoEnvironment() }),
        .init { state, action, env in
            switch action {
            case .addTodo:
                state.todos.insert(Todo(id: env.uuid), at: 0)
                return .none

            case .delete(let indexSet):
                state.todos.remove(atOffsets: indexSet)
                return .none

            case .sortCompletedTodos:
                state.todos.sort { !$0.isComplete && $1.isComplete }
                return .none

            case .todo(id: let id, action: .toggleCheckbox):
                struct TodoCompletionID: Hashable {}
                return EffectTask(value: .sortCompletedTodos)
                    .debounce(id: TodoCompletionID(), for: 1, scheduler: env.scheduler)

            case .todo:
                return .none
            }
        }
    )
