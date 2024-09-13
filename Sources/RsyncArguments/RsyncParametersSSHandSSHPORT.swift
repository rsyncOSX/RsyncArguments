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
            // either set global or local
            // ssh params only apply if remote server
            if let sshport, sshport != "-1",
               let sshkeypathandidentityfile,
               sshkeypathandidentityfile.isEmpty == false {
                sshparameterslocal(forDisplay: forDisplay)
            } else if let sharedsshkeypathandidentityfile,
                      sharedsshkeypathandidentityfile.isEmpty == false,
                      let sharedsshport,
                      sharedsshport != "-1" {
                sshparametersglobal(forDisplay: forDisplay)
            }
        }

        return computedarguments
    }

    override public init(
        offsiteServer: String,
        sshport: String?,
        sshkeypathandidentityfile: String?,
        sharedsshport: String?,
        sharedsshkeypathandidentityfile: String?,
        rsyncversion3: Bool
    ) {
        super.init(offsiteServer: offsiteServer,
                   sshport: sshport,
                   sshkeypathandidentityfile: sshkeypathandidentityfile,
                   sharedsshport: sharedsshport,
                   sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
                   rsyncversion3: rsyncversion3)
    }
}
