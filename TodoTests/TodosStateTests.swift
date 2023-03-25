//
//  TodosStateTests.swift
//  TodoTests
//
//  Created by Fabio Salata on 25/03/23.
//

import XCTest
import ComposableArchitecture
@testable import Todo

final class TodosStateTests: XCTestCase {
    var store = TestStore(initialState: TodosState(),
                          reducer: todosReducer,
                          environment:  TodosEnvironment(uuid: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
                                                         scheduler: DispatchQueue.test.eraseToAnyScheduler()))
    

    func test_addTodo_withSuccess() {
        store.send(.addTodo) {
            $0.todos.insert(
                Todo(
                    id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
                    title: "",
                    isComplete: false
                ),
                at: 0
            )
        }
    }
}
