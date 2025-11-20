//  ParameterError.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 02/08/2024.
//

import Foundation

/// Errors that can occur during rsync parameter generation
public enum ParameterError: LocalizedError {
    case missingLocalCatalog
    case missingOffsiteCatalog
    case missingOffsiteServer
    case missingOffsiteUsername
    case invalidTaskType
    case invalidSnapshotNumber
    case invalidSSHConfiguration
    
    public var errorDescription: String? {
        switch self {
        case .missingLocalCatalog:
            return "Local catalog path is required"
        case .missingOffsiteCatalog:
            return "Offsite catalog path is required"
        case .missingOffsiteServer:
            return "Offsite server address is required"
        case .missingOffsiteUsername:
            return "Offsite username is required"
        case .invalidTaskType:
            return "Invalid task type specified"
        case .invalidSnapshotNumber:
            return "Invalid snapshot number"
        case .invalidSSHConfiguration:
            return "SSH configuration is incomplete or invalid"
        }
    }
}
