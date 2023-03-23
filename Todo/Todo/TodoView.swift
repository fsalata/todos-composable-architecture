//
//  TodoView.swift
//  Todo
//
//  Created by Fabio Salata on 23/03/23.
//

import SwiftUI
import ComposableArchitecture

struct TodoView: View {
    let store: Store<Todo, TodoAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button {
                    viewStore.send(.toggleCheckbox)
                } label: {
                    Image(systemName: viewStore.isComplete ? "checkmark.square" : "square")
                }
                .buttonStyle(.plain)

                TextField("Untitled Todo", text: viewStore.binding(get: \.title, send: TodoAction.changeTextField))
                    .strikethrough(viewStore.isComplete)
            }
            .foregroundColor(viewStore.isComplete ? .gray : nil)
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Todo.placeholders) { todo in
          TodoView(store: .init(
            initialState: todo,
            reducer: todoReducer,
            environment: TodoEnvironment()
          ))
          .previewLayout(.fixed(width: 300, height: 50))
          .padding()
        }
    }
}
