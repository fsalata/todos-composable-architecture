//
//  TodosState.swift
//  Todo
//
//  Created by Fabio Salata on 23/03/23.
//

import Foundation
import ComposableArchitecture

struct TodosState: Equatable {
    var todos: IdentifiedArrayOf<Todo> = []
}

extension TodosState {
  static let placeholder = Self(
    todos: [
      .init(id: .init(), title: "Buy milk", isComplete: false),
      .init(id: .init(), title: "Organize desk", isComplete: false),
      .init(id: .init(), title: "Call Mom", isComplete: true),
    ]
  )
}
