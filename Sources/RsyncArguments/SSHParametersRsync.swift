//
//  SSHParameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 08/08/2024.
//

import Foundation

public class SSHParametersRsync {
    // -e "ssh -i ~/.ssh/id_myserver -p 22"
    // -e "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
    // default is
    // -e "ssh -i ~/.ssh/id_rsa -p 22"

    var computedarguments = [String]()

    var parameter5 = ""
    var parameter6 = ""

    var offsiteServer = ""
    var sshport: String?
    var sshkeypathandidentityfile: String?
    var sharedsshport: String?
    var sharedsshkeypathandidentityfile: String?

    var rsyncversion3 = false

    // Local params rules global settings
    public func sshparameterslocal(forDisplay: Bool) {
        var sshportadded = false
        var sshkeypathandidentityfileadded = false

        computedarguments.append(parameter5)
        if forDisplay { computedarguments.append(" ") }
        if let sshkeypathandidentityfile {
            sshkeypathandidentityfileadded = true
            if forDisplay { computedarguments.append(" \"") }
            // Then check if ssh port is set also
            if let sshport {
                sshportadded = true
                // "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
                computedarguments.append("ssh -i " + sshkeypathandidentityfile + " " + "-p " + String(sshport))
            } else {
                computedarguments.append("ssh -i " + sshkeypathandidentityfile)
            }
            if forDisplay { computedarguments.append("\" ") }
        }
        if let sshport {
            // "ssh -p xxx"
            if sshportadded == false {
                sshportadded = true
                if forDisplay { computedarguments.append(" \"") }
                computedarguments.append("ssh -p " + String(sshport))
                if forDisplay { computedarguments.append("\" ") }
            }
        } else {
            // ssh
            if sshportadded == false, sshkeypathandidentityfileadded == false {
                computedarguments.append(parameter6)
            }
        }
        if forDisplay { computedarguments.append(" ") }
    }

    // Global ssh parameters
    public func sshparametersglobal(forDisplay: Bool) {
        var sshportadded = false
        var sshkeypathandidentityfileadded = false

        computedarguments.append(parameter5)
        if forDisplay { computedarguments.append(" ") }
        if let sshkeypathandidentityfile = sharedsshkeypathandidentityfile {
            sshkeypathandidentityfileadded = true
            if forDisplay { computedarguments.append(" \"") }
            // Then check if ssh port is set also
            if let sshport = sharedsshport {
                sshportadded = true
                // "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
                computedarguments.append("ssh -i " + sshkeypathandidentityfile + " " + "-p " + String(sshport))
            } else {
                computedarguments.append("ssh -i " + sshkeypathandidentityfile)
            }
            if forDisplay { computedarguments.append("\" ") }
        }
        if let sshport = sharedsshport {
            // "ssh -p xxx"
            if sshportadded == false {
                sshportadded = true
                if forDisplay { computedarguments.append(" \"") }
                computedarguments.append("ssh -p " + String(sshport))
                if forDisplay { computedarguments.append("\" ") }
            }
        } else {
            // ssh
            if sshportadded == false, sshkeypathandidentityfileadded == false {
                computedarguments.append(parameter6)
            }
        }
        if forDisplay { computedarguments.append(" ") }
    }

    public init(parameter5: String,
                parameter6: String,
                offsiteServer: String,
                sshport: String?,
                sshkeypathandidentityfile: String?,
                sharedsshport: String?,
                sharedsshkeypathandidentityfile: String?,
                rsyncversion3: Bool) {
        self.parameter5 = parameter5
        self.parameter6 = parameter6
        self.offsiteServer = offsiteServer
        self.sshport = sshport
        self.sshkeypathandidentityfile = sshkeypathandidentityfile
        self.sharedsshport = sharedsshport
        self.sharedsshkeypathandidentityfile = sharedsshkeypathandidentityfile
        self.rsyncversion3 = rsyncversion3

        computedarguments.removeAll()
    }
}
