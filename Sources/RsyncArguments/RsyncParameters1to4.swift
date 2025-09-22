//
//  RsyncParameters1to4.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 02/08/2024.
//
// swiftlint:disable cyclomatic_complexity

import Foundation

public final class RsyncParameters1to4: SSHParametersRsync {
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
