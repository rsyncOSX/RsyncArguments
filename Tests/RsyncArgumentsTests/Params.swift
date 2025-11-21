//
//  Params.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 21/11/2025.
//
@testable import RsyncArguments

struct Params {
    func params(
        config: TestSynchronizeConfiguration) -> Parameters
    {
        var rsyncdaemon = false
        if config.rsyncdaemon == 1 { rsyncdaemon = true }
        return Parameters(
            task: config.task,
            basicParameters: BasicRsyncParameters(
                archiveMode: "--archive",
                verboseOutput: "--verbose",
                compressionEnabled: "--compress",
                deleteExtraneous: "--delete"
            ),
            optionalParameters: OptionalRsyncParameters(parameter8: config.parameter8,
                                                        parameter9: config.parameter9,
                                                        parameter10: config.parameter10,
                                                        parameter11: config.parameter11,
                                                        parameter12: config.parameter12,
                                                        parameter13: config.parameter13,
                                                        parameter14: config.parameter14),

            sshParameters: SSHParameters(
                offsiteServer: config.offsiteServer,
                offsiteUsername: config.offsiteUsername,
                sshport: String(config.sshport ?? -1),
                sshkeypathandidentityfile: config.sshkeypathandidentityfile ?? "",
                sharedsshport: String(TestSharedReference.shared.sshport ?? -1),
                sharedsshkeypathandidentityfile: TestSharedReference.shared.sshkeypathandidentityfile,
                rsyncversion3: TestSharedReference.shared.rsyncversion3
            ),
            paths: PathConfiguration(
                localCatalog: config.localCatalog,
                offsiteCatalog: config.offsiteCatalog,
                sharedPathForRestore: "/Users/thomas/tmp"
            ),
            snapshotNumber: config.snapshotnum,
            isRsyncDaemon: rsyncdaemon, // Use Bool instead of -1/1
            rsyncVersion3: TestSharedReference.shared.rsyncversion3
        )
    }
    
    func sshparams(
        config: TestSynchronizeConfiguration) -> SSHParameters
    {
        SSHParameters(
            offsiteServer: config.offsiteServer,
            offsiteUsername: config.offsiteUsername,
            sshport: String(config.sshport ?? -1),
            sshkeypathandidentityfile: config.sshkeypathandidentityfile ?? "",
            sharedsshport: String(TestSharedReference.shared.sshport ?? -1),
            sharedsshkeypathandidentityfile: TestSharedReference.shared.sshkeypathandidentityfile,
            rsyncversion3: TestSharedReference.shared.rsyncversion3
        )
    }

}
