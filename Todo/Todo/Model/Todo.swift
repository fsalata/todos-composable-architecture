//
//  Todo.swift
//  Todo
//
//  Created by Fabio Salata on 23/03/23.
//

import Foundation

struct Todo: Equatable, Identifiable, Codable {
    var id: UUID
    var title = ""
    var isComplete = false
}

extension Todo {
  static let placeholders: [Self] = [
    .init(id: .init()),
    .init(id: .init(), title: "Buy milk", isComplete: false),
    .init(id: .init(), title: "Call Mom", isComplete: true),
  ]
}
