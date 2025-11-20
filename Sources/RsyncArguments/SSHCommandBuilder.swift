//
//  SSHCommands.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 10/08/2024.
//  Consolidated SSH command building logic
//

import Foundation

/// Base class for SSH command builders
public class SSHCommandBuilder {
    public var computedArguments = [String]()
    
    let sshParameters: SSHParameters
    let sshParamBuilder: SSHParameterBuilder
    
    public init(sshParameters: SSHParameters) {
        self.sshParameters = sshParameters
        self.sshParamBuilder = SSHParameterBuilder(sshParameters: sshParameters)
    }
    
    /// Adds SSH connection parameters to the command
    func addSSHParameters() {
        let params = sshParamBuilder.buildSSHCommandParameters()
        computedArguments.append(contentsOf: params)
    }
    
    /// Adds a parameter to the command
    public func appendParameter(_ parameter: String) {
        computedArguments.append(parameter)
    }
    
    /// Builds remote user@server string
    var remoteUserHost: String {
        "\(sshParameters.username)@\(sshParameters.server)"
    }
}

// MARK: - Snapshot Operations

/// Builds command for creating snapshot root catalog
public final class SnapshotCreateRootCatalog: SSHCommandBuilder {
    public let remoteCommand = "/usr/bin/ssh"
    
    /// Builds command to create snapshot root catalog
    /// - Parameter offsiteCatalog: The catalog path to create
    /// - Returns: Array of command arguments
    public func snapshotCreateRootCatalog(offsiteCatalog: String) -> [String] {
        computedArguments.removeAll()
        
        if sshParameters.isRemote {
            addSSHParameters()
            appendParameter(remoteUserHost)
        }
        
        appendParameter("mkdir -p \(offsiteCatalog)")
        return computedArguments
    }
}

/// Builds command for deleting snapshots
public final class SnapshotDelete: SSHCommandBuilder {
    public let remoteCommand = "/usr/bin/ssh"
    public let localCommand = "/bin/rm"
    
    /// Builds command to delete a snapshot catalog
    /// - Parameter remoteCatalog: The catalog path to delete
    /// - Returns: Array of command arguments
    public func snapshotDelete(remoteCatalog: String) -> [String] {
        computedArguments.removeAll()
        
        if sshParameters.isRemote {
            addSSHParameters()
            appendParameter(remoteUserHost)
            appendParameter("rm -rf \(remoteCatalog)")
        } else {
            appendParameter("-rf")
            appendParameter(remoteCatalog)
        }
        
        return computedArguments
    }
}

/// Builds rsync arguments for listing remote catalog contents
public final class RemoteSize {
    public private(set) var computedArguments = [String]()
    
    private let sshParameters: SSHParameters
    private let sshBuilder: SSHParameterBuilder
    
    public init(sshParameters: SSHParameters) {
        self.sshParameters = sshParameters
        self.sshBuilder = SSHParameterBuilder(sshParameters: sshParameters)
    }
    
    /// Builds rsync arguments for listing remote catalog
    /// - Parameter remoteCatalog: The remote catalog path to list
    /// - Returns: Array of rsync arguments for listing
    public func remoteDiskSize(remoteCatalog: String) -> [String]? {
        guard sshParameters.isRemote else { return nil }
        
        computedArguments.removeAll()
        
        var builder = RsyncArgumentBuilder()
        
        // Add rsync list parameters
        builder.add("--verbose")
        builder.add("--compress")
        builder.add("-r")
        builder.add("--list-only")
        
        // Add SSH parameters - CORRECTED: forDisplay should be false
        builder.addAll(sshBuilder.buildRsyncSSHParameters(forDisplay: false))
        
        // Add remote argument
        let remoteArg = sshBuilder.buildRemoteArgument(
            catalog: remoteCatalog,
            isDaemon: false
        )
        builder.add(remoteArg)
        
        computedArguments = builder.build()
        return computedArguments
    }
}
