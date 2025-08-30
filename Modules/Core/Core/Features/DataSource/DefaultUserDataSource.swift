//
//  DefaultUserDataSource.swift
//  Core
//
//  Created by Adrian-Zoltan Herczeg on 28.08.2025.
//

import Foundation

/// Default implementation of the ``UserDataSource``.
public class DefaultUserDataSource: UserDataSource {
    // MARK: - typealias
    
    private typealias UserDataSourceInMemoryStore = [UserDataSourceInMemoryKey : Data]
    
    // MARK: - Private Properties
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private var inMemoryStore = UserDataSourceInMemoryStore()
    
    // MARK: - Init
    
    /// Creates a new `DefaultUserDataSource`.
    public init() {}
    
    // MARK: - UserDataSource Methods
    
    public func read<T>(as type: T.Type, at key: UserDataSourceInMemoryKey) -> T? where T : Decodable, T : Encodable {
        guard
            let storedData = inMemoryStore[key],
            let decodedData = try? decoder.decode(T.self, from: storedData) else {
            return nil
        }
        return decodedData
    }
    
    public func write<T>(vatlue data: T, for key: UserDataSourceInMemoryKey) where T : Decodable, T : Encodable {
        guard let encodedData = try? encoder.encode(data) else {
            return
        }
        inMemoryStore[key] = encodedData
    }
    
    public func isAvailable<T>(at key: UserDataSourceInMemoryKey, type: T.Type?) -> Bool where T : Decodable, T : Encodable {
        guard let storedData = inMemoryStore[key] else {
            return false
        }
        guard let type else {
            return true
        }
        let decodedData = try? decoder.decode(type, from: storedData)
        return decodedData != nil
    }
    
    public func removeValue(for key: UserDataSourceInMemoryKey) {
        inMemoryStore.removeValue(forKey: key)
    }
}
