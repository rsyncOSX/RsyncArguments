//
//  RsyncParameters1to6.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 02/08/2024.
//
// swiftlint:disable cyclomatic_complexity

import Foundation

public final class RsyncParameters1to6: SSHParametersRsync {
    // -e "ssh -i ~/.ssh/id_myserver -p 22"
    // -e "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
    // default is
    // -e "ssh -i ~/.ssh/id_rsa -p 22"

    var parameter1 = ""
    var parameter2 = ""
    var parameter3 = ""
    var parameter4 = ""

    public func setParameters1To4(forDisplay: Bool, verify: Bool) -> [String] {
        if verify {
            parameter1 = DefaultRsyncParameters.verify_parameter1.rawValue
        } else {
            parameter1 = DefaultRsyncParameters.archive_parameter1.rawValue
        }
        computedarguments.append(parameter1)
        if verify {
            if forDisplay { computedarguments.append(" ") }
            computedarguments.append(DefaultRsyncParameters.recursive.rawValue)
        }
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(parameter2)
        if forDisplay { computedarguments.append(" ") }
        if offsiteServer.isEmpty == false {
            if parameter3.isEmpty == false {
                computedarguments.append(parameter3)
                if forDisplay { computedarguments.append(" ") }
            }
        }
        if parameter4.isEmpty == false {
            computedarguments.append(parameter4)
            if forDisplay { computedarguments.append(" ") }
        }
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
            } else if let sharedsshkeypathandidentityfile,
                      sharedsshkeypathandidentityfile.isEmpty == false {
                // Shared SSH keypathandidentityfile
                sshparametersglobal(forDisplay: forDisplay)
            } else if let sshkeypathandidentityfile,
                          sshkeypathandidentityfile.isEmpty == false {
                    // SSH keypathandidentityfile,
                    sshparameterslocal(forDisplay: forDisplay)
            } else if let sharedsshport,
                      sharedsshport != "-1" {
                // Shared global SSH-port only
                sshparametersglobal(forDisplay: forDisplay)
            } else if let sshport, sshport != "-1" {
                // Shared ssh port only
                sshparameterslocal(forDisplay: forDisplay)
            }
        }

        return computedarguments
    }

    public init(parameter1: String,
                parameter2: String,
                parameter3: String,
                parameter4: String,
                offsiteServer: String,
                sshport: String?,
                sshkeypathandidentityfile: String?,
                sharedsshport: String?,
                sharedsshkeypathandidentityfile: String?,
                rsyncversion3: Bool) {
        super.init(offsiteServer: offsiteServer,
                   sshport: sshport,
                   sshkeypathandidentityfile: sshkeypathandidentityfile,
                   sharedsshport: sharedsshport,
                   sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
                   rsyncversion3: rsyncversion3)

        self.parameter1 = parameter1
        self.parameter2 = parameter2
        self.parameter3 = parameter3
        self.parameter4 = parameter4
        self.offsiteServer = offsiteServer
        self.sshport = sshport
        self.sshkeypathandidentityfile = sshkeypathandidentityfile
        self.sharedsshport = sharedsshport
        self.sharedsshkeypathandidentityfile = sharedsshkeypathandidentityfile
        self.rsyncversion3 = rsyncversion3
    }
}

// swiftlint:enable cyclomatic_complexity