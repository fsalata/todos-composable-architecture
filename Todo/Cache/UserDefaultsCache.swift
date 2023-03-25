//
//  UserDefaultsCache.swift
//  Todo
//
//  Created by Fabio Salata on 25/03/23.
//

import Foundation
import ComposableArchitecture

final class UserDefaultsCache: Caching {
    let key: String
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    let userDefaults: UserDefaults

    init(key: String,
         decoder: JSONDecoder = .init(),
         encoder: JSONEncoder = .init()) {
        guard let userDefaults = UserDefaults(suiteName: key) else {
            fatalError("Unable to create store with key: \(key)")
        }

        self.key = key
        self.userDefaults = userDefaults
        self.decoder = decoder
        self.encoder = encoder
    }

    func save<Value>(_ value: Value) where Value : Encodable {
        guard let data = try? encoder.encode(value) else { return }

        userDefaults.set(data, forKey: key)
    }

    func load<Value>() -> Value? where Value : Decodable {
        guard let data = userDefaults.data(forKey: key) else { return nil }

        return try? decoder.decode(Value.self, from: data)
    }
}

extension AnyReducer where State: Codable {
    func caching(cache: Caching, ignoreCachingDuplicates isDuplicate: ((State, State) -> Bool)? = nil) -> AnyReducer {
        return .init { state, action, environment in
            let previousState = state
            let effects = self.run(&state, action, environment)
            let nextState = state

            if isDuplicate?(previousState, nextState) == true {
                return effects
            }

            return .merge(.fireAndForget {cache.save(nextState) }, effects)
        }
    }
}
