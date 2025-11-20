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
        self.coreParamsBuilder = RsyncCoreParameters(
            basicParameters: parameters.basicParameters,
            sshParameters: parameters.sshParameters
        )
        self.optionalParamsBuilder = RsyncOptionalParameters(
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
        verify: Bool,
        dryrun: Bool
    ) throws {
        guard parameters.task != DefaultRsyncParameters.syncremote.rawValue,
              parameters.task != DefaultRsyncParameters.snapshot.rawValue else {
            throw ParameterError.invalidTaskType
        }
        
        var builder = RsyncArgumentBuilder()
        
        // Basic parameters
        builder.add(DefaultRsyncParameters.archiveMode.rawValue)
        if forDisplay { builder.add(" ") }
        builder.add(DefaultRsyncParameters.verboseOutput.rawValue)
        if forDisplay { builder.add(" ") }
        builder.add(DefaultRsyncParameters.compressionEnabled.rawValue)
        if forDisplay { builder.add(" ") }
        
        // Dry run if requested
        if dryrun {
            builder.add(DefaultRsyncParameters.dryRunMode.rawValue)
            if forDisplay { builder.add(" ") }
        }
        
        builder.add("--stats")
        if forDisplay { builder.add(" ") }
        builder.add("--exclude=.git/")
        if forDisplay { builder.add(" ") }
        builder.add("--exclude=.DS_Store")
        if forDisplay { builder.add(" ") }
        
        // SSH parameters - only if configured
        if parameters.sshParameters.isRemote && parameters.sshParameters.effectiveConfig.hasConfiguration {
            let sshBuilder = SSHParameterBuilder(sshParameters: parameters.sshParameters)
            builder.addAll(sshBuilder.buildRsyncSSHParameters(forDisplay: forDisplay))
            if forDisplay { builder.add(" ") }
        }
        
        // Source (remote) and destination (local)
        builder.add(buildRemoteSource(catalog: parameters.paths.offsiteCatalog))
        if forDisplay { builder.add(" ") }
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
        guard parameters.task != DefaultRsyncParameters.syncremote.rawValue,
              parameters.task != DefaultRsyncParameters.snapshot.rawValue else {
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
            if forDisplay && index < result.count && result[index] == " " {
                result.remove(at: index)
            }
        }
        
        return result
    }
}
