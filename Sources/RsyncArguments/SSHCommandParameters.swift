//
//  SSHCommandParameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 10/08/2024.
//

import Foundation

public class SSHCommandParameters {
    var computedarguments = [String]()

    var offsiteServer = ""
    var sshport: String?
    var sshkeypathandidentityfile: String?
    var sharedsshport: String?
    var sharedsshkeypathandidentityfile: String?

    var rsyncversion3 = false

    public func setsshidentityfileandsshport() -> [String] {
        if offsiteServer.isEmpty == false {
            if let sshport, sshport != "-1",
               let sshkeypathandidentityfile,
               sshkeypathandidentityfile.isEmpty == false
            {
                sshcommandparameterslocal()
            } else if let sharedsshkeypathandidentityfile,
                      sharedsshkeypathandidentityfile.isEmpty == false,
                      let sharedsshport,
                      sharedsshport != "-1"
            {
                sshcommandparametersglobal()
            }
            return computedarguments
        }
        return []
    }

    // Local params rules global settings
    public func sshcommandparameterslocal() {
        var sshportadded = false

        if let sshkeypathandidentityfile {
            // Then check if ssh port is set also
            if let sshport {
                sshportadded = true
                // "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
                computedarguments.append("-i " + sshkeypathandidentityfile + " " + "-p " + String(sshport))
            } else {
                computedarguments.append("-i " + sshkeypathandidentityfile)
            }
        }
        if let sshport {
            // "ssh -p xxx"
            if sshportadded == false {
                sshportadded = true
                computedarguments.append("-p " + String(sshport))
            }
        }
    }

    // Global ssh parameters
    public func sshcommandparametersglobal() {
        var sshportadded = false
        if let sshkeypathandidentityfile = sharedsshkeypathandidentityfile {
            // Then check if ssh port is set also
            if let sshport = sharedsshport {
                sshportadded = true
                // "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
                computedarguments.append("-i " + sshkeypathandidentityfile + " " + "-p " + String(sshport))
            } else {
                computedarguments.append("-i " + sshkeypathandidentityfile)
            }
        }
        if let sshport = sharedsshport {
            // "ssh -p xxx"
            if sshportadded == false {
                sshportadded = true
                computedarguments.append("-p " + String(sshport))
            }
        }
    }

    public init(offsiteServer: String,
                sshport: String?,
                sshkeypathandidentityfile: String?,
                sharedsshport: String?,
                sharedsshkeypathandidentityfile: String?,
                rsyncversion3: Bool)
    {
        self.offsiteServer = offsiteServer
        self.sshport = sshport
        self.sshkeypathandidentityfile = sshkeypathandidentityfile
        self.sharedsshport = sharedsshport
        self.sharedsshkeypathandidentityfile = sharedsshkeypathandidentityfile
        self.rsyncversion3 = rsyncversion3

        computedarguments.removeAll()
    }
    
    
    public init(sshparameters: SSHParameters) {
        self.offsiteServer = sshparameters.offsiteServer
        self.sshport = sshparameters.sshport
        self.sshkeypathandidentityfile = sshparameters.sshkeypathandidentityfile
        self.sharedsshport = sshparameters.sharedsshport
        self.sharedsshkeypathandidentityfile = sshparameters.sharedsshkeypathandidentityfile
        self.rsyncversion3 = sshparameters.rsyncversion3

        computedarguments.removeAll()
    }
}
