//
//  UserDataSource.swift
//  Core
//
//  Created by Adrian-Zoltan Herczeg on 28.08.2025.
//

import Foundation

/// Type responsbile for managing the storage of the user related information across the app.
public protocol UserDataSource {
    /// Reads the value found at the corresponding `key` and retuns it as the provided type.
    /// - Parameters:
    ///   - type: The type in which the data should be decoded.
    ///   - key: They corresponding in memory key which should contain the target information.
    /// - Returns: Instance of provided `type` if the data exists and can be decoded in the specified type, or `nil` otherwise.
    func read<T>(as type: T.Type, at key: UserDataSourceInMemoryKey) -> T? where T: Codable
    /// Stores the provided piece of data at the given the speicfied key.
    /// - Parameters:
    ///   - vatlue: The data which should be stored.
    ///   - key: An in memory key which will serve as the store addess for the provided data.
    func write<T>(vatlue: T, for key: UserDataSourceInMemoryKey) where T: Codable
    /// Checks if a specified piece of data is available in the in memory store.
    /// - Parameters:
    ///   - key: The key used as identifier for the specific information.
    ///   - type: Optional type for which to compare the stored information against for validation.
    /// - Returns: `True` if the correspnding key contains the specified data, false otherwise.
    ///
    /// - Note: If no specifc type is provided, the store wil check only if the provided key has an associated piece of data with it.
    func isAvailable<T>(at key: UserDataSourceInMemoryKey, type: T.Type?) -> Bool where T: Codable
    /// Removes a value from the in memory store, corresponding to the provided key.
    /// - Parameter key: The key from which the data should be removed.
    func removeValue(for key: UserDataSourceInMemoryKey)
}
