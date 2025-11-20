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
    
    /// Legacy initializer for backward compatibility
    public init(
        task: String,
        parameter1: String,
        parameter2: String,
        parameter3: String,
        parameter4: String,
        parameter8: String?,
        parameter9: String?,
        parameter10: String?,
        parameter11: String?,
        parameter12: String?,
        parameter13: String?,
        parameter14: String?,
        sshport: String?,
        sshkeypathandidentityfile: String?,
        sharedsshport: String?,
        sharedsshkeypathandidentityfile: String?,
        localCatalog: String,
        offsiteCatalog: String,
        offsiteServer: String,
        offsiteUsername: String,
        sharedpathforrestore: String,
        snapshotnum: Int,
        rsyncdaemon: Int,
        rsyncversion3: Bool
    ) {
        let basic = BasicRsyncParameters(
            archiveMode: parameter1,
            verboseOutput: parameter2,
            compressionEnabled: parameter3,
            deleteExtraneous: parameter4
        )
        
        let optional = OptionalRsyncParameters(
            parameter8: parameter8,
            parameter9: parameter9,
            parameter10: parameter10,
            parameter11: parameter11,
            parameter12: parameter12,
            parameter13: parameter13,
            parameter14: parameter14
        )
        
        let ssh = SSHParameters(
            offsiteServer: offsiteServer,
            offsiteUsername: offsiteUsername,
            sshport: sshport,
            sshkeypathandidentityfile: sshkeypathandidentityfile,
            sharedsshport: sharedsshport,
            sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
            rsyncversion3: rsyncversion3
        )
        
        let pathConfig = PathConfiguration(
            localCatalog: localCatalog,
            offsiteCatalog: offsiteCatalog,
            sharedPathForRestore: sharedpathforrestore
        )
        
        self.init(
            task: task,
            basicParameters: basic,
            optionalParameters: optional,
            sshParameters: ssh,
            paths: pathConfig,
            snapshotNumber: snapshotnum >= 0 ? snapshotnum : nil,
            isRsyncDaemon: rsyncdaemon == 1,
            rsyncVersion3: rsyncversion3
        )
    }
}
