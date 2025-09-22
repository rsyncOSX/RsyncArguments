//
//  SSHCommandParametersInitialize.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 10/08/2024.
//

import Foundation

public class SSHCommandParametersInitialize {
    public private(set) var computedarguments = [String]()

    var offsiteServer = ""
    var offsiteUsername = ""
    var sshport: String?
    var sshkeypathandidentityfile: String?
    var sharedsshport: String?
    var sharedsshkeypathandidentityfile: String?

    var rsyncversion3 = false

    public func initialise_setsshidentityfileandsshport() {
        let setsshidentityfileandsshport = SSHCommandParameters(
            offsiteServer: offsiteServer,
            sshport: sshport,
            sshkeypathandidentityfile: sshkeypathandidentityfile,
            sharedsshport: sharedsshport,
            sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
            rsyncversion3: rsyncversion3
        )

        computedarguments += setsshidentityfileandsshport.setsshidentityfileandsshport()
    }

    public func appendparameter(_ parameter: String) {
        computedarguments.append(parameter)
    }

    public init(sshparameters: SSHParameters) {
        offsiteServer = sshparameters.offsiteServer
        offsiteUsername = sshparameters.offsiteUsername
        sshport = sshparameters.sshport
        sshkeypathandidentityfile = sshparameters.sshkeypathandidentityfile
        sharedsshport = sshparameters.sharedsshport
        sharedsshkeypathandidentityfile = sshparameters.sharedsshkeypathandidentityfile
        rsyncversion3 = sshparameters.rsyncversion3

        computedarguments.removeAll()
    }
}
