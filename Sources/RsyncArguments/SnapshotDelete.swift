//
//  SnapshotDelete.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 11/08/2024.
//

import Foundation

public final class SnapshotDelete: SSHCommandParametersInitialize {
    public let remotecommand = "/usr/bin/ssh"
    public let localcommand = "/bin/rm"

    public func snapshotdelete(remotecatalog: String) -> [String] {
        if offsiteServer.isEmpty == false {
            let remotearges = offsiteUsername + "@" + offsiteServer
            appendparameter(remotearges)
            let remotecommand = "rm -rf " + remotecatalog
            appendparameter(remotecommand)
            return computedarguments
        } else {
            appendparameter("-rf")
            appendparameter(remotecatalog)
            return computedarguments
        }
    }

    override public init(offsiteServer: String,
                         offsiteUsername: String,
                         sshport: String?,
                         sshkeypathandidentityfile: String?,
                         sharedsshport: String?,
                         sharedsshkeypathandidentityfile: String?,
                         rsyncversion3: Bool)
    {
        super.init(offsiteServer: offsiteServer,
                   offsiteUsername: offsiteUsername,
                   sshport: sshport,
                   sshkeypathandidentityfile: sshkeypathandidentityfile,
                   sharedsshport: sharedsshport,
                   sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
                   rsyncversion3: rsyncversion3)
    }
    
    override public init(sshparameters: SSHParameters) {
        super.init(sshparameters: sshparameters)
    }
}
