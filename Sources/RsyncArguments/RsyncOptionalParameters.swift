//
//  RsyncOptionalParameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 03/08/2024.
//  Refactored for clarity and maintainability
//

import Foundation

/// Handles user-defined optional rsync parameters (8-14)
public final class RsyncOptionalParameters {
    private let optionalParams: OptionalRsyncParameters
    private let rsyncVersion3: Bool

    public init(optionalParameters: OptionalRsyncParameters, rsyncVersion3: Bool) {
        optionalParams = optionalParameters
        self.rsyncVersion3 = rsyncVersion3
    }

    /// Builds optional parameter arguments
    /// - Parameters:
    ///   - dryRun: Whether this is a dry run
    ///   - forDisplay: Whether to add spacing for display
    /// - Returns: Array of optional arguments
    public func buildArguments(dryRun: Bool, forDisplay: Bool) -> [String] {
        var builder = RsyncArgumentBuilder()
        var hasStatsParameter = false

        // Process parameters 8-14
        let parameters = [
            optionalParams.parameter8,
            optionalParams.parameter9,
            optionalParams.parameter10,
            optionalParams.parameter11,
            optionalParams.parameter12,
            optionalParams.parameter13,
            optionalParams.parameter14,
        ]

        for param in parameters {
            if let param, !param.isEmpty, param.count > 1 {
                if param == DefaultRsyncParameters.statisticsOutput.rawValue {
                    hasStatsParameter = true
                }
                builder.add(param)
                if forDisplay { builder.add(" ") }
            }
        }

        // Add dry-run and stats parameters
        if dryRun {
            builder.add(DefaultRsyncParameters.dryRunMode.rawValue)
            if forDisplay { builder.add(" ") }
        }

        if !hasStatsParameter {
            builder.add(DefaultRsyncParameters.statisticsOutput.rawValue)
            if forDisplay { builder.add(" ") }
        }

        return builder.build()
    }
}

// MARK: - Date Suffix Extension

private extension String {
    /// Appends current date in format -yyyy-MM-dd
    var withDateSuffix: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "-yyyy-MM-dd"
        return self + formatter.string(from: Date())
    }
}
