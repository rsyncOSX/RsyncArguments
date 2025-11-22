//
//  BasicRsyncParameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 23/09/2024.
//  Refactored for improved clarity and maintainability
//

import Foundation

/// Core rsync parameters with clear, descriptive names
public struct BasicRsyncParameters {
    public let archiveMode: String
    public let verboseOutput: String
    public let compressionEnabled: String
    public let deleteExtraneous: String
    
    public init(
        archiveMode: String,
        verboseOutput: String,
        compressionEnabled: String,
        deleteExtraneous: String
    ) {
        self.archiveMode = archiveMode
        self.verboseOutput = verboseOutput
        self.compressionEnabled = compressionEnabled
        self.deleteExtraneous = deleteExtraneous
    }
}

/// Optional user-defined rsync parameters (8-14)
public struct OptionalRsyncParameters {
    public let parameter8: String?
    public let parameter9: String?
    public let parameter10: String?
    public let parameter11: String?
    public let parameter12: String?
    public let parameter13: String?
    public let parameter14: String?
    
    public init(
        parameter8: String? = nil,
        parameter9: String? = nil,
        parameter10: String? = nil,
        parameter11: String? = nil,
        parameter12: String? = nil,
        parameter13: String? = nil,
        parameter14: String? = nil
    ) {
        self.parameter8 = parameter8
        self.parameter9 = parameter9
        self.parameter10 = parameter10
        self.parameter11 = parameter11
        self.parameter12 = parameter12
        self.parameter13 = parameter13
        self.parameter14 = parameter14
    }
}

/// Path configuration for source and destination
public struct PathConfiguration {
    public let localCatalog: String
    public let offsiteCatalog: String
    public let sharedPathForRestore: String
    
    public init(
        localCatalog: String,
        offsiteCatalog: String,
        sharedPathForRestore: String = ""
    ) {
        self.localCatalog = localCatalog
        self.offsiteCatalog = offsiteCatalog
        self.sharedPathForRestore = sharedPathForRestore
    }
}

/// Complete parameter configuration for an rsync task
public struct Parameters {
    public let task: String
    public let basicParameters: BasicRsyncParameters
    public let optionalParameters: OptionalRsyncParameters
    public let sshParameters: SSHParameters
    public let paths: PathConfiguration
    
    public let snapshotNumber: Int?
    public let isRsyncDaemon: Bool
    public let rsyncVersion3: Bool
    
    public init(
        task: String,
        basicParameters: BasicRsyncParameters,
        optionalParameters: OptionalRsyncParameters,
        sshParameters: SSHParameters,
        paths: PathConfiguration,
        snapshotNumber: Int?,
        isRsyncDaemon: Bool,
        rsyncVersion3: Bool
    ) {
        self.task = task
        self.basicParameters = basicParameters
        self.optionalParameters = optionalParameters
        self.sshParameters = sshParameters
        self.paths = paths
        self.snapshotNumber = snapshotNumber
        self.isRsyncDaemon = isRsyncDaemon
        self.rsyncVersion3 = rsyncVersion3
    }
}
