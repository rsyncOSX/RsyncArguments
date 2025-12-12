//
//  RsyncParametersRestore.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 07/08/2024.
//  Refactored to eliminate state mutation and improve clarity
//

import Foundation

/// Builds rsync arguments for restore operations and file listings
public final class RsyncParametersRestore {
    public private(set) var computedArguments = [String]()

    private let parameters: Parameters
    private let sshBuilder: SSHParameterBuilder

    public init(parameters: Parameters) {
        self.parameters = parameters
        sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
    }

    // MARK: - File Listing Operations

    /// Builds arguments for listing remote files
    /// - Throws: ParameterError if server is not configured
    public func remoteArgumentsFileList() throws {
        guard parameters.sshParameters.isRemote else {
            throw ParameterError.missingOffsiteServer
        }

        var builder = RsyncArgumentBuilder()
        builder.add(DefaultRsyncParameters.verboseOutput.rawValue)
        builder.add(DefaultRsyncParameters.compressionEnabled.rawValue)
        builder.add("-r")
        builder.add("--list-only")

        // Only add SSH parameters if they're configured
        if parameters.sshParameters.effectiveConfig.hasConfiguration {
            let sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
            builder.addAll(sshBuilder.buildRsyncSSHParameters(forDisplay: false))
        }

        builder.add(buildRemoteSource(catalog: parameters.paths.offsiteCatalog))

        computedArguments = builder.build()
    }

    /// Builds arguments for listing snapshot catalogs
    /// - Throws: ParameterError if configuration is invalid
    public func remoteArgumentsSnapshotCatalogList() throws {
        guard parameters.rsyncVersion3 else {
            throw ParameterError.invalidTaskType
        }

        guard parameters.sshParameters.isRemote else {
            throw ParameterError.missingOffsiteServer
        }

        var builder = RsyncArgumentBuilder()
        builder.add(DefaultRsyncParameters.verboseOutput.rawValue)
        builder.add(DefaultRsyncParameters.compressionEnabled.rawValue)
        builder.add("--list-only")

        // Only add SSH parameters if they're configured
        if parameters.sshParameters.effectiveConfig.hasConfiguration {
            let sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
            builder.addAll(sshBuilder.buildRsyncSSHParameters(forDisplay: false))
        }

        builder.add(buildRemoteSource(catalog: parameters.paths.offsiteCatalog))

        computedArguments = builder.build()
    }

    /// Builds arguments for listing files within a snapshot catalog
    /// - Throws: ParameterError if configuration is invalid
    public func remoteArgumentsSnapshotFileList() throws {
        guard parameters.rsyncVersion3 else {
            throw ParameterError.invalidTaskType
        }

        guard parameters.sshParameters.isRemote else {
            throw ParameterError.missingOffsiteServer
        }

        guard let snapshotNum = parameters.snapshotNumber else {
            throw ParameterError.invalidSnapshotNumber
        }

        let snapshotCatalog = parameters.paths.offsiteCatalog + String(snapshotNum - 1) + "/"

        var builder = RsyncArgumentBuilder()
        builder.add(DefaultRsyncParameters.verboseOutput.rawValue)
        builder.add(DefaultRsyncParameters.compressionEnabled.rawValue)
        builder.add("-r")
        builder.add("--list-only")

        // Only add SSH parameters if they're configured
        if parameters.sshParameters.effectiveConfig.hasConfiguration {
            let sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
            builder.addAll(sshBuilder.buildRsyncSSHParameters(forDisplay: false))
        }

        builder.add(buildRemoteSource(catalog: snapshotCatalog))

        computedArguments = builder.build()
    }

    // MARK: - Restore Operations

    /// Builds arguments for restoring files from remote
    /// - Parameters:
    ///   - forDisplay: Whether to format for display
    ///   - verify: Whether to use verification mode
    ///   - dryrun: Whether this is a dry run
    ///   - restoreSnapshotByFiles: Whether to restore specific files from snapshot
    /// - Throws: ParameterError if configuration is invalid
    public func argumentsRestore(
        forDisplay: Bool,
        verify _: Bool,
        dryrun: Bool,
        restoreSnapshotByFiles: Bool
    ) throws {
        // Validate configuration
        guard parameters.task != DefaultRsyncParameters.syncremote.rawValue else {
            throw ParameterError.invalidTaskType
        }

        guard parameters.sshParameters.isRemote else {
            throw ParameterError.missingOffsiteServer
        }

        guard !parameters.paths.sharedPathForRestore.isEmpty else {
            throw ParameterError.missingLocalCatalog
        }

        var builder = RsyncArgumentBuilder()

        // Core parameters
        addCoreParameters(to: &builder, forDisplay: forDisplay, dryrun: dryrun)

        // SSH parameters
        addSSHParameters(to: &builder, forDisplay: forDisplay)

        // Source (remote)
        let remoteCatalog = try computeRemoteCatalog(restoreSnapshotByFiles: restoreSnapshotByFiles)
        addRemoteAndLocalPaths(to: &builder, remoteCatalog: remoteCatalog, forDisplay: forDisplay)

        computedArguments = builder.build()
    }

    private func addCoreParameters(to builder: inout RsyncArgumentBuilder, forDisplay: Bool, dryrun: Bool) {
        builder.add(DefaultRsyncParameters.archiveMode.rawValue)
        if forDisplay { builder.add(" ") }
        builder.add(DefaultRsyncParameters.verboseOutput.rawValue)
        if forDisplay { builder.add(" ") }
        builder.add(DefaultRsyncParameters.compressionEnabled.rawValue)
        if forDisplay { builder.add(" ") }

        if dryrun {
            builder.add(DefaultRsyncParameters.dryRunMode.rawValue)
            if forDisplay { builder.add(" ") }
        }

        builder.add("--stats")
        if forDisplay { builder.add(" ") }
    }

    private func addSSHParameters(to builder: inout RsyncArgumentBuilder, forDisplay: Bool) {
        guard parameters.sshParameters.effectiveConfig.hasConfiguration else {
            return
        }
        let sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
        builder.addAll(sshBuilder.buildRsyncSSHParameters(forDisplay: forDisplay))
    }

    private func computeRemoteCatalog(restoreSnapshotByFiles: Bool) throws -> String {
        let isSnapshot = parameters.snapshotNumber != nil

        guard !isSnapshot || !restoreSnapshotByFiles else {
            return parameters.paths.offsiteCatalog
        }

        guard isSnapshot else {
            return parameters.paths.offsiteCatalog
        }

        guard let snapshotNum = parameters.snapshotNumber else {
            throw ParameterError.invalidSnapshotNumber
        }

        return parameters.paths.offsiteCatalog + String(snapshotNum - 1) + "/"
    }

    private func addRemoteAndLocalPaths(to builder: inout RsyncArgumentBuilder, remoteCatalog: String, forDisplay: Bool) {
        if forDisplay { builder.add(" ") }
        builder.add(buildRemoteSource(catalog: remoteCatalog))
        if forDisplay { builder.add(" ") }
        builder.add(parameters.paths.sharedPathForRestore)
    }

    // MARK: - Private Helpers

    /// Builds remote source string without mutation
    private func buildRemoteSource(catalog: String) -> String {
        sshBuilder.buildRemoteArgument(catalog: catalog, isDaemon: parameters.isRsyncDaemon)
    }
}
