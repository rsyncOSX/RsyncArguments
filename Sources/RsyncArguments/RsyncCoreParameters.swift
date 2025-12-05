//
//  RsyncCoreParameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 02/08/2024.
//  Refactored from RsyncParameters1to4
//

import Foundation

/// Handles core rsync parameters (archive, verbose, compress, delete) and SSH configuration
public final class RsyncCoreParameters {
    private let basicParams: BasicRsyncParameters
    private let sshParams: SSHParameters
    private let sshBuilder: SSHParameterBuilder

    public init(basicParameters: BasicRsyncParameters, sshParameters: SSHParameters) {
        basicParams = basicParameters
        sshParams = sshParameters
        sshBuilder = SSHParameterBuilder(sshParameters: sshParameters)
    }

    /// Builds core parameter arguments
    /// - Parameters:
    ///   - forDisplay: Whether to add spacing for display
    ///   - verify: If true, uses --checksum instead of --archive
    /// - Returns: Array of core rsync arguments
    public func buildArguments(forDisplay: Bool, verify: Bool) -> [String] {
        var builder = RsyncArgumentBuilder()

        // First parameter: archive or verify (checksum)
        if verify {
            builder.add(DefaultRsyncParameters.verifyChecksum.rawValue)
            if forDisplay { builder.add(" ") }
            builder.add(DefaultRsyncParameters.recursiveMode.rawValue)
        } else {
            builder.add(basicParams.archiveMode.isEmpty
                ? DefaultRsyncParameters.archiveMode.rawValue
                : basicParams.archiveMode)
        }

        if forDisplay { builder.add(" ") }

        // Verbose parameter
        builder.add(basicParams.verboseOutput.isEmpty
            ? DefaultRsyncParameters.verboseOutput.rawValue
            : basicParams.verboseOutput)

        if forDisplay { builder.add(" ") }

        // Compression parameter (only for remote connections)
        if sshParams.isRemote, !basicParams.compressionEnabled.isEmpty {
            builder.add(basicParams.compressionEnabled)
            if forDisplay { builder.add(" ") }
        }

        // Delete parameter
        if !basicParams.deleteExtraneous.isEmpty {
            builder.add(basicParams.deleteExtraneous)
            if forDisplay { builder.add(" ") }
        }

        // SSH parameters (only for remote connections WITH SSH configuration)
        if sshParams.isRemote, sshParams.effectiveConfig.hasConfiguration {
            builder.addAll(sshBuilder.buildRsyncSSHParameters(forDisplay: forDisplay))
        }

        return builder.build()
    }
}
