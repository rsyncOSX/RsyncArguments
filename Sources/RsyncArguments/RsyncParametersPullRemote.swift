//
//  RsyncParametersPullRemote.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 19/11/2025.
//

//
//  RsyncParametersPullRemote.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 13/11/2024.
//  Refactored to eliminate state mutation
//

import Foundation

/// Builds rsync arguments for pulling data from remote sources
public final class RsyncParametersPullRemote {
    public private(set) var computedArguments = [String]()

    private let parameters: Parameters
    private let coreParamsBuilder: RsyncCoreParameters
    private let optionalParamsBuilder: RsyncOptionalParameters

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
    }

    // MARK: - Public API

    /// Builds basic arguments for pulling from remote without custom parameters
    /// - Parameters:
    ///   - forDisplay: Whether to format for display
    ///   - verify: Whether to use verification mode
    ///   - dryrun: Whether this is a dry run
    /// - Throws: ParameterError if task type is invalid
    public func argumentsPullRemote(
        forDisplay: Bool,
        verify _: Bool,
        dryrun: Bool
    ) throws {
        guard parameters.task == DefaultRsyncParameters.synchronize.rawValue else {
            throw ParameterError.invalidTaskType
        }

        var builder = RsyncArgumentBuilder()

        // Basic parameters
        addParameter(DefaultRsyncParameters.archiveMode.rawValue, to: &builder, forDisplay: forDisplay)
        addParameter(DefaultRsyncParameters.verboseOutput.rawValue, to: &builder, forDisplay: forDisplay)
        addParameter(DefaultRsyncParameters.compressionEnabled.rawValue, to: &builder, forDisplay: forDisplay)

        // Dry run if requested
        if dryrun {
            addParameter(DefaultRsyncParameters.dryRunMode.rawValue, to: &builder, forDisplay: forDisplay)
        }

        addParameter("--stats", to: &builder, forDisplay: forDisplay)
        addParameter("--exclude=.git/", to: &builder, forDisplay: forDisplay)
        addParameter("--exclude=.DS_Store", to: &builder, forDisplay: forDisplay)

        // SSH parameters - only if configured
        addSSHParametersIfNeeded(to: &builder, forDisplay: forDisplay)

        // Source (remote) and destination (local)
        addParameter(buildRemoteSource(catalog: parameters.paths.offsiteCatalog), to: &builder, forDisplay: forDisplay)
        builder.add(parameters.paths.localCatalog)

        computedArguments = builder.build()
    }

    /// Builds arguments for pulling from remote with full parameter customization
    /// - Parameters:
    ///   - forDisplay: Whether to format for display
    ///   - verify: Whether to use verification mode
    ///   - dryrun: Whether this is a dry run
    ///   - keepDelete: Whether to keep the --delete flag
    /// - Throws: ParameterError if task type is invalid
    public func argumentsPullRemoteWithParameters(
        forDisplay: Bool,
        verify: Bool,
        dryrun: Bool,
        keepDelete: Bool
    ) throws {
        guard parameters.task == DefaultRsyncParameters.synchronize.rawValue else {
            throw ParameterError.invalidTaskType
        }

        // Build standard arguments
        var args = coreParamsBuilder.buildArguments(forDisplay: forDisplay, verify: verify)
        args += optionalParamsBuilder.buildArguments(dryRun: dryrun, forDisplay: forDisplay)

        // Remove --delete if requested
        if !keepDelete {
            args = removeParameter("--delete", from: args, forDisplay: forDisplay)
        }

        var builder = RsyncArgumentBuilder()
        builder.addAll(args)

        // Add update and exclude parameters
        builder.add("--update")
        if forDisplay { builder.add(" ") }
        builder.add("--itemize-changes")
        if forDisplay { builder.add(" ") }
        builder.add("--exclude=.git/")
        if forDisplay { builder.add(" ") }
        builder.add("--exclude=.DS_Store")
        if forDisplay { builder.add(" ") }

        // Source (remote) and destination (local)
        if forDisplay { builder.add(" ") }
        builder.add(buildRemoteSource(catalog: parameters.paths.offsiteCatalog))
        if forDisplay { builder.add(" ") }
        builder.add(parameters.paths.localCatalog)

        computedArguments = builder.build()
    }

    // MARK: - Private Helpers

    /// Adds a parameter to the builder with optional display spacing
    private func addParameter(_ param: String, to builder: inout RsyncArgumentBuilder, forDisplay: Bool) {
        builder.add(param)
        if forDisplay { builder.add(" ") }
    }
    
    /// Adds an array of parameters to the builder with optional display spacing
    private func addParameters(_ params: [String], to builder: inout RsyncArgumentBuilder, forDisplay: Bool) {
        for param in params {
            builder.add(param)
            if forDisplay { builder.add(" ") }
        }
    }

    /// Adds SSH parameters to the builder if they are configured
    private func addSSHParametersIfNeeded(to builder: inout RsyncArgumentBuilder, forDisplay: Bool) {
        let sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
        let sshParams = sshBuilder.buildRsyncSSHParameters(forDisplay: forDisplay)
        if !sshParams.isEmpty {
            addParameters(sshParams, to: &builder, forDisplay: forDisplay)
        }
    }

    /// Builds remote source string without mutation
    private func buildRemoteSource(catalog: String) -> String {
        let sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
        return sshBuilder.buildRemoteArgument(catalog: catalog, isDaemon: parameters.isRsyncDaemon)
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

