//
//  SSHCommandParametersInitialize.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 10/08/2024.
//

import Foundation

@MainActor
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

    public init(offsiteServer: String,
                offsiteUsername: String,
                sshport: String?,
                sshkeypathandidentityfile: String?,
                sharedsshport: String?,
                sharedsshkeypathandidentityfile: String?,
                rsyncversion3: Bool) {
        self.offsiteServer = offsiteServer
        self.offsiteUsername = offsiteUsername
        self.sshport = sshport
        self.sshkeypathandidentityfile = sshkeypathandidentityfile
        self.sharedsshport = sharedsshport
        self.sharedsshkeypathandidentityfile = sharedsshkeypathandidentityfile
        self.rsyncversion3 = rsyncversion3

        computedarguments.removeAll()
    }
}
