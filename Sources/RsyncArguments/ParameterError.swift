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
            "Local catalog path is required"
        case .missingOffsiteCatalog:
            "Offsite catalog path is required"
        case .missingOffsiteServer:
            "Offsite server address is required"
        case .missingOffsiteUsername:
            "Offsite username is required"
        case .invalidTaskType:
            "Invalid task type specified"
        case .invalidSnapshotNumber:
            "Invalid snapshot number"
        case .invalidSSHConfiguration:
            "SSH configuration is incomplete or invalid"
        }
    }
}
