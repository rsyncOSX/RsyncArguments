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
            let remotearges = offsiteUsername + "@" + offsiteServer
            appendparameter(remotearges)
        }
        let remotecommand = "mkdir -p " + offsiteCatalog
        appendparameter(remotecommand)
        return computedarguments
    }
    
    override public init(sshparameters: SSHParameters) {
        super.init(sshparameters: sshparameters)
    }
}
