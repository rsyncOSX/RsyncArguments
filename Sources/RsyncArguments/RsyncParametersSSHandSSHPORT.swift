//
//  RsyncParametersSSHandSSHPORT.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 08/08/2024.
//

import Foundation

public final class RsyncParametersSSHandSSHPORT: SSHParametersRsync {
    public func setParametersSSHandSSHPORT(forDisplay: Bool, verify _: Bool) -> [String] {
        if offsiteServer.isEmpty == false {
            if let verify: Verifysshparameters = verifysshparameters() {
                switch verify {
                case .localesshport:
                    sshparameterslocal(forDisplay: forDisplay)
                case .localesshkeypath:
                    sshparameterslocal(forDisplay: forDisplay)
                case .alllocale:
                    sshparameterslocal(forDisplay: forDisplay)
                case .allglobal:
                    sshparametersglobal(forDisplay: forDisplay)
                case .essh:
                    setessh(forDisplay: forDisplay)
                }
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
