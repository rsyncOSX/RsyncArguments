//
//  RemoteSize.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 01/12/2024.
//

import Foundation

public final class RemoteSize: SSHCommandParametersInitialize {
    public let remotecommand = "/usr/bin/ssh"

    public func remotedisksize(remotecatalog: String) -> [String]? {
        if offsiteServer.isEmpty == false {
            let remotearges = offsiteUsername + "@" + offsiteServer
            appendparameter(remotearges)
            let remotecommand = "df -H | grep " + "'" + remotecatalog + "'"
            appendparameter(remotecommand)
            return computedarguments
        }
        return nil
    }

    override public init(sshparameters: SSHParameters) {
        super.init(sshparameters: sshparameters)
    }
}
