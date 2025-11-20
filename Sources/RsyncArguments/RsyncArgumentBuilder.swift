//
//  RsyncArgumentBuilder.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 02/08/2024.
//  Refactored for improved maintainability
//

import Foundation

/// Helper for building rsync argument arrays with optional display formatting
public struct RsyncArgumentBuilder {
    private var arguments: [String] = []
    
    /// Adds a single argument to the builder
    /// - Parameter argument: The argument to add
    /// - Returns: Self for method chaining
    @discardableResult
    public mutating func add(_ argument: String) -> Self {
        arguments.append(argument)
        return self
    }
    
    /// Conditionally adds an argument
    /// - Parameters:
    ///   - condition: Whether to add the argument
    ///   - argument: The argument to add if condition is true
    /// - Returns: Self for method chaining
    @discardableResult
    public mutating func addIf(_ condition: Bool, _ argument: String) -> Self {
        if condition {
            arguments.append(argument)
        }
        return self
    }
    
    /// Adds multiple arguments
    /// - Parameter arguments: Array of arguments to add
    /// - Returns: Self for method chaining
    @discardableResult
    public mutating func addAll(_ arguments: [String]) -> Self {
        self.arguments.append(contentsOf: arguments)
        return self
    }
    
    /// Builds the final argument array
    /// - Parameter forDisplay: If true, adds spacing between arguments for display
    /// - Returns: Array of arguments, with optional spacing
    public func build(forDisplay: Bool = false) -> [String] {
        if forDisplay {
            return arguments.flatMap { [$0, " "] }
        }
        return arguments
    }
    
    /// Returns a human-readable string of all arguments
    public var displayString: String {
        arguments.joined(separator: " ")
    }
}
