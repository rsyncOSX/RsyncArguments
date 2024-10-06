//
//  SSHParameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 24/09/2024.
//

public class SSHParameters {
    var offsiteServer = ""
    var offsiteUsername = ""
    var sshport: String?
    var sshkeypathandidentityfile: String?
    var sharedsshport: String?
    var sharedsshkeypathandidentityfile: String?
    var rsyncversion3 = false

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
    }
}
