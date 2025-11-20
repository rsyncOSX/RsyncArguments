//
//  SSHParameterBuilder.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 08/08/2024.
//  Consolidated SSH parameter building logic
//

import Foundation

/// Type of SSH parameter configuration
public enum SSHParameterType {
    case localPortOnly
    case localKeyOnly
    case localComplete
    case sharedComplete
    case defaultSSH
}

/// Builds SSH parameters for rsync commands
public struct SSHParameterBuilder {
    private let sshParameters: SSHParameters
    
    public init(sshParameters: SSHParameters) {
        self.sshParameters = sshParameters
    }
    
    /// Determines which type of SSH configuration should be used
    public var parameterType: SSHParameterType {
        let local = sshParameters.localConfig
        let shared = sshParameters.sharedConfig
        
        if local.port != nil, local.identityFile == nil {
            return .localPortOnly
        } else if local.identityFile != nil, local.port == nil {
            return .localKeyOnly
        } else if local.port != nil, local.identityFile != nil {
            return .localComplete
        } else if shared.hasConfiguration {
            return .sharedComplete
        } else {
            return .defaultSSH
        }
    }
    
    /// Builds SSH parameters for rsync -e option
    /// - Parameter forDisplay: Whether to add spacing for display
    /// - Returns: Array of arguments including -e and ssh parameters
    public func buildRsyncSSHParameters(forDisplay: Bool) -> [String] {
        guard sshParameters.isRemote else { return [] }
        
        var result: [String] = []
        
        result.append("-e")
        if forDisplay { result.append(" ") }
        
        let sshCommand = buildSSHCommandString()
        
        if forDisplay {
            result.append("\"")
            result.append(sshCommand)
            result.append("\"")
            result.append(" ")
        } else {
            result.append(sshCommand)
        }
        
        return result
    }
    
    /// Builds SSH command parameters for direct ssh invocations
    /// - Returns: Array of SSH parameters (e.g., ["-i", "/path", "-p", "22"])
    public func buildSSHCommandParameters() -> [String] {
        guard sshParameters.isRemote else { return [] }
        
        let config = sshParameters.effectiveConfig
        var params: [String] = []
        
        if let identityFile = config.identityFile {
            params.append("-i")
            params.append(identityFile)
        }
        
        if let port = config.port {
            params.append("-p")
            params.append(String(port))
        }
        
        return params
    }
    
    /// Builds the SSH command string for rsync -e option
    /// - Returns: String like "ssh -i /path -p 22" (without outer quotes)
    private func buildSSHCommandString() -> String {
        let config = sshParameters.effectiveConfig
        var parts: [String] = ["ssh"]
        
        if let identityFile = config.identityFile {
            parts.append("-i \(identityFile)")
        }
        
        if let port = config.port {
            parts.append("-p \(port)")
        }
        
        return parts.joined(separator: " ")
    }
    
    /// Builds remote argument string (username@server:path or username@server::path)
    /// - Parameters:
    ///   - catalog: The remote catalog path
    ///   - isDaemon: Whether this is an rsync daemon connection
    /// - Returns: Complete remote argument string
    public func buildRemoteArgument(catalog: String, isDaemon: Bool) -> String {
        let separator = isDaemon ? "::" : ":"
        return "\(sshParameters.username)@\(sshParameters.server)\(separator)\(catalog)"
    }
}
