//
//  SSHConfiguration.swift
//  RsyncArguments
//
//  Refactored for type safety and clarity
//

import Foundation

/// SSH connection configuration
public struct SSHConfiguration {
    public let port: Int?
    public let identityFile: String?
    
    public init(port: Int?, identityFile: String?) {
        self.port = port
        self.identityFile = identityFile
    }
    
    /// Creates configuration from string port representation
    public init(portString: String?, identityFile: String?) {
        if let portString = portString, portString != "-1", let port = Int(portString) {
            self.port = port
        } else {
            self.port = nil
        }
        
        self.identityFile = (identityFile?.isEmpty == false) ? identityFile : nil
    }
    
    /// Whether this configuration has any SSH parameters set
    public var hasConfiguration: Bool {
        port != nil || identityFile != nil
    }
    
    /// Validates the configuration
    public var isValid: Bool {
        if let port = port {
            guard (1...65535).contains(port) else { return false }
        }
        if let file = identityFile {
            guard !file.isEmpty else { return false }
        }
        return true
    }
}

/// Extension to make existing SSHParameters work with new code
extension SSHParameters {
    public var localConfig: SSHConfiguration {
        SSHConfiguration(portString: sshport, identityFile: sshkeypathandidentityfile)
    }
    
    public var sharedConfig: SSHConfiguration {
        SSHConfiguration(portString: sharedsshport, identityFile: sharedsshkeypathandidentityfile)
    }
    
    public var server: String { offsiteServer }
    public var username: String { offsiteUsername }
    public var isRemote: Bool { !offsiteServer.isEmpty }
    
    /// Determines which SSH configuration to use - matches original verifysshparameters logic
    public var effectiveConfig: SSHConfiguration {
        let localPortSet = sshport != nil && sshport != "-1"
        let localKeySet = sshkeypathandidentityfile != nil && sshkeypathandidentityfile?.isEmpty == false
        
        // If ANY local SSH parameter is actually set, use local
        if localPortSet || localKeySet {
            return localConfig
        }
        
        // No local parameters set, check for shared/global
        let sharedPortSet = sharedsshport != nil && sharedsshport != "-1"
        let sharedKeySet = sharedsshkeypathandidentityfile != nil && sharedsshkeypathandidentityfile?.isEmpty == false
        
        // If ANY shared parameter is set, use shared
        if sharedPortSet || sharedKeySet {
            return sharedConfig
        }
        
        // Nothing set, return empty config
        return SSHConfiguration(port: nil, identityFile: nil)
    }
}
