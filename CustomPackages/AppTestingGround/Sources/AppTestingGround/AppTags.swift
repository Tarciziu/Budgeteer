// The Swift Programming Language
// https://docs.swift.org/swift-book

import Testing

// List of extensions which should be used for clasifying all tests in every module across the app.
public extension Tag {
  /// Tag used to mark tests deemed as `flaky`.
  ///
  /// May be appied to tests which fail randomly due to cases such as concurrency or third party libraries underlying issues.
  ///
  /// - Note: These tests should be fixed at earliest convinience.
  @Tag static var flaky: Self
  /// Tag used to mark tests for content which is considered `critical` to the app.
  ///
  /// `Critical` content may refer to either security relaed zones in the app(such as keychain or notifications registration)
  /// or core business entities used across the entire app.
  @Tag static var critical: Self
}
