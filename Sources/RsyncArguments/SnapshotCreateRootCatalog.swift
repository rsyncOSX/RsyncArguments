//
//  SnapshotCreateRootCatalog.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 11/08/2024.
//

import Foundation

public final class SnapshotCreateRootCatalog: SSHCommandParametersInitialize {
    public let remotecommand = "/usr/bin/ssh"

    public func snapshotcreaterootcatalog(offsiteCatalog: String) -> [String] {
        if offsiteServer.isEmpty == false {
            appendparameter(remotearges())
        }
        let remotecommand = "mkdir -p " + offsiteCatalog
        appendparameter(remotecommand)
        return computedarguments
    }

    private func remotearges() -> String {
        offsiteUsername + "@" + offsiteServer
    }

    override public init(offsiteServer: String,
                         offsiteUsername: String,
                         sshport: String?,
                         sshkeypathandidentityfile: String?,
                         sharedsshport: String?,
                         sharedsshkeypathandidentityfile: String?,
                         rsyncversion3: Bool) {
        super.init(offsiteServer: offsiteServer,
                   offsiteUsername: offsiteUsername,
                   sshport: sshport,
                   sshkeypathandidentityfile: sshkeypathandidentityfile,
                   sharedsshport: sharedsshport,
                   sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
                   rsyncversion3: rsyncversion3)
    }
}
