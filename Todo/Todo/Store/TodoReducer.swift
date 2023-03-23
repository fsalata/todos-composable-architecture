//
//  TodoActions.swift
//  Todo
//
//  Created by Fabio Salata on 23/03/23.
//

import Foundation
import ComposableArchitecture

struct TodoEnvironment {}

enum TodoAction: Equatable {
    case toggleCheckbox
    case changeTextField(String)
}

let todoReducer = AnyReducer<Todo, TodoAction, TodoEnvironment> { state, action, env in
    switch action {
    case .toggleCheckbox:
        state.isComplete.toggle()
        return .none
    case .changeTextField(let title):
        state.title = title
        return .none
    }
}


