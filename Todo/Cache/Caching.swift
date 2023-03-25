//
//  Caching.swift
//  Todo
//
//  Created by Fabio Salata on 25/03/23.
//

import Foundation

protocol Caching {
    var key: String { get }
    func save<Value: Encodable>(_ value: Value)
    func load<Value: Decodable>() -> Value?
}
