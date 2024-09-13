//
//  RsyncParametersSSHandSSHPORT.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 08/08/2024.
//

import Foundation

public final class RsyncParametersSSHandSSHPORT: SSHParametersRsync {
    public func setParameters1SSHandSSHPORT(forDisplay: Bool, verify _: Bool) -> [String] {
        if offsiteServer.isEmpty == false {
            // We have to check for both global and local ssh parameters.
            // either set global or local, parameter5 = remote server
            // ssh params only apply if remote server
            if parameter5.isEmpty == false {
                if let sshport, sshport != "-1", let sshkeypathandidentityfile, sshkeypathandidentityfile.isEmpty == false {
                    sshparameterslocal(forDisplay: forDisplay)
                } else if sharedsshkeypathandidentityfile != nil || sharedsshport != nil {
                    sshparametersglobal(forDisplay: forDisplay)
                }
            }
        }

        return computedarguments
    }

    override public init(
        parameter5: String,
        offsiteServer: String,
        sshport: String?,
        sshkeypathandidentityfile: String?,
        sharedsshport: String?,
        sharedsshkeypathandidentityfile: String?,
        rsyncversion3: Bool
    ) {
        super.init(parameter5: parameter5,
                   offsiteServer: offsiteServer,
                   sshport: sshport,
                   sshkeypathandidentityfile: sshkeypathandidentityfile,
                   sharedsshport: sharedsshport,
                   sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
                   rsyncversion3: rsyncversion3)
    }
}
