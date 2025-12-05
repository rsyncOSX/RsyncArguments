//
//  RsyncParametersSynchronize.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 03/08/2024.
//  Fully refactored for improved maintainability and type safety
//

import Foundation

/// Builds rsync arguments for synchronization, snapshot, and remote sync tasks
public final class RsyncParametersSynchronize {
    public private(set) var computedArguments = [String]()

    private let parameters: Parameters
    private let coreParamsBuilder: RsyncCoreParameters
    private let optionalParamsBuilder: RsyncOptionalParameters
    private let sshBuilder: SSHParameterBuilder

    public init(parameters: Parameters) {
        self.parameters = parameters
        coreParamsBuilder = RsyncCoreParameters(
            basicParameters: parameters.basicParameters,
            sshParameters: parameters.sshParameters
        )
        optionalParamsBuilder = RsyncOptionalParameters(
            optionalParameters: parameters.optionalParameters,
            rsyncVersion3: parameters.rsyncVersion3
        )
        sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
    }

    // MARK: - Public API

    /// Builds arguments for standard synchronization
    /// - Parameters:
    ///   - forDisplay: Whether to format for display
    ///   - verify: Whether to use checksum verification
    ///   - dryrun: Whether this is a dry run
    /// - Throws: ParameterError if configuration is invalid
    public func argumentsForSynchronize(forDisplay: Bool, verify: Bool, dryrun: Bool) throws {
        guard parameters.task == DefaultRsyncParameters.synchronize.rawValue else {
            throw ParameterError.invalidTaskType
        }

        computedArguments = buildStandardArguments(forDisplay: forDisplay, verify: verify, dryrun: dryrun)

        // Add source
        computedArguments.append(parameters.paths.localCatalog)
        if forDisplay { computedArguments.append(" ") }

        // Add destination
        if parameters.sshParameters.isRemote {
            computedArguments.append(buildRemoteDestination(catalog: parameters.paths.offsiteCatalog))
        } else {
            computedArguments.append(parameters.paths.offsiteCatalog)
        }

        if forDisplay { computedArguments.append(" ") }
    }

    /// Builds arguments for pushing local changes to remote (with optional --delete removal)
    /// - Parameters:
    ///   - forDisplay: Whether to format for display
    ///   - verify: Whether to use checksum verification
    ///   - dryrun: Whether this is a dry run
    ///   - keepDelete: Whether to keep the --delete flag
    /// - Throws: ParameterError if task type is invalid
    public func argumentsForPushLocalToRemoteWithParameters(
        forDisplay: Bool,
        verify: Bool,
        dryrun: Bool,
        keepDelete: Bool
    ) throws {
        // Require a standard "synchronize" task type for pushing local -> remote
        guard parameters.task == DefaultRsyncParameters.synchronize.rawValue else {
            throw ParameterError.invalidTaskType
        }

        var args = buildStandardArguments(forDisplay: forDisplay, verify: verify, dryrun: dryrun)

        // Remove --delete if requested
        if !keepDelete {
            args = removeParameter("--delete", from: args, forDisplay: forDisplay)
        }

        // Remove existing exclude parameters
        args = removeParameter("--exclude=.git/", from: args, forDisplay: forDisplay)
        args = removeParameter("--exclude=.DS_Store", from: args, forDisplay: forDisplay)

        // Add update and exclude parameters
        var builder = RsyncArgumentBuilder()
        builder.addAll(args)

        builder.add("--update")
        if forDisplay { builder.add(" ") }
        builder.add("--itemize-changes")
        if forDisplay { builder.add(" ") }
        builder.add("--exclude=.git/")
        if forDisplay { builder.add(" ") }
        builder.add("--exclude=.DS_Store")
        if forDisplay { builder.add(" ") }

        // Add source and destination
        builder.add(parameters.paths.localCatalog)
        if forDisplay { builder.add(" ") }

        if parameters.sshParameters.isRemote {
            builder.add(buildRemoteDestination(catalog: parameters.paths.offsiteCatalog))
        } else {
            builder.add(parameters.paths.offsiteCatalog)
        }

        if forDisplay { builder.add(" ") }

        computedArguments = builder.build()
    }

    /// Builds arguments for synchronizing from remote source
    /// - Parameters:
    ///   - forDisplay: Whether to format for display
    ///   - verify: Whether to use checksum verification
    ///   - dryrun: Whether this is a dry run
    /// - Throws: ParameterError if configuration is invalid
    public func argumentsForSynchronizeRemote(
        forDisplay: Bool,
        verify: Bool,
        dryrun: Bool
    ) throws {
        guard parameters.task == DefaultRsyncParameters.syncremote.rawValue else {
            throw ParameterError.invalidTaskType
        }

        guard parameters.sshParameters.isRemote else {
            throw ParameterError.missingOffsiteServer
        }

        var builder = RsyncArgumentBuilder()
        builder.addAll(buildStandardArguments(forDisplay: forDisplay, verify: verify, dryrun: dryrun))

        if forDisplay { builder.add(" ") }

        // For syncremote, source is remote (local catalog on remote server)
        builder.add(buildRemoteSource(catalog: parameters.paths.localCatalog))
        if forDisplay { builder.add(" ") }

        // Destination is offsite catalog
        builder.add(parameters.paths.offsiteCatalog)
        if forDisplay { builder.add(" ") }

        computedArguments = builder.build()
    }

    /// Builds arguments for snapshot synchronization
    /// - Parameters:
    ///   - forDisplay: Whether to format for display
    ///   - verify: Whether to use checksum verification
    ///   - dryrun: Whether this is a dry run
    /// - Throws: ParameterError if configuration is invalid
    public func argumentsForSynchronizeSnapshot(
        forDisplay: Bool,
        verify: Bool,
        dryrun: Bool
    ) throws {
        guard parameters.task == DefaultRsyncParameters.snapshot.rawValue else {
            throw ParameterError.invalidTaskType
        }

        guard let snapshotNum = parameters.snapshotNumber else {
            throw ParameterError.invalidSnapshotNumber
        }

        var builder = RsyncArgumentBuilder()
        builder.addAll(buildStandardArguments(forDisplay: forDisplay, verify: verify, dryrun: dryrun))

        // Add link-dest parameter
        let linkDestCatalog = parameters.paths.offsiteCatalog + String(snapshotNum - 1)
        let linkDest = DefaultRsyncParameters.linkDestination.rawValue + linkDestCatalog
        builder.add(linkDest)
        if forDisplay { builder.add(" ") }

        // Add source
        builder.add(parameters.paths.localCatalog)
        if forDisplay { builder.add(" ") }

        // Add destination with snapshot number
        let destinationCatalog: String = if verify {
            parameters.paths.offsiteCatalog + String(snapshotNum - 1)
        } else {
            parameters.paths.offsiteCatalog + String(snapshotNum)
        }

        if parameters.sshParameters.isRemote {
            builder.add(buildRemoteDestination(catalog: destinationCatalog))
        } else {
            builder.add(destinationCatalog)
        }

        if forDisplay { builder.add(" ") }

        computedArguments = builder.build()
    }

    // MARK: - Private Helpers

    /// Builds standard rsync arguments (core + optional parameters)
    private func buildStandardArguments(forDisplay: Bool, verify: Bool, dryrun: Bool) -> [String] {
        var args: [String] = []
        args += coreParamsBuilder.buildArguments(forDisplay: forDisplay, verify: verify)
        args += optionalParamsBuilder.buildArguments(dryRun: dryrun, forDisplay: forDisplay)
        return args
    }

    /// Builds remote destination string
    private func buildRemoteDestination(catalog: String) -> String {
        sshBuilder.buildRemoteArgument(catalog: catalog, isDaemon: parameters.isRsyncDaemon)
    }

    /// Builds remote source string
    private func buildRemoteSource(catalog: String) -> String {
        sshBuilder.buildRemoteArgument(catalog: catalog, isDaemon: parameters.isRsyncDaemon)
    }

    /// Removes a parameter from argument array, handling display spacing
    private func removeParameter(_ param: String, from args: [String], forDisplay: Bool) -> [String] {
        var result = args

        if let index = result.firstIndex(of: param) {
            result.remove(at: index)

            // Remove trailing space if present
            if forDisplay, index < result.count, result[index] == " " {
                result.remove(at: index)
            }
        }

        return result
    }
}
