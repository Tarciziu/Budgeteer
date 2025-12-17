//
//  TypeAliases.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 11.11.2025.
//

import Foundation

/// A typealias for a closure that takes no parameters and returns no value.
public typealias Action = () -> Void

/// A typealias for a closure that takes a parameter of type `T` and returns a type `G`.
public typealias GenericAction<T, G> = (T) -> G
