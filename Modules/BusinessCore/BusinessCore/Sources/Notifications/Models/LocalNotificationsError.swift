//
//  LocalNotificationsError.swift
//  BusinessCore
//
//  Created by Adrian-Zoltan Herczeg on 11/04/2026.
//

import Foundation

/// Type describing possible errors which can appear in the local notifications process.
public enum LocalNotificationsError: Error {
  case authorizationFailure
}
