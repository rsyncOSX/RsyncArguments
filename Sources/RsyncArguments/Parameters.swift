//
//  Parameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 23/09/2024.
//


public final class Parameters {
    var task = ""
    
    var parameter1 = ""
    var parameter2 = ""
    var parameter3 = ""
    var parameter4 = ""

    var parameter8: String?
    var parameter9: String?
    var parameter10: String?
    var parameter11: String?
    var parameter12: String?
    var parameter13: String?
    var parameter14: String?

    var sshport: String?
    var sshkeypathandidentityfile: String?
    var sharedsshport: String?
    var sharedsshkeypathandidentityfile: String?

    var localCatalog = ""
    var offsiteCatalog = ""
    var offsiteServer = ""
    var offsiteUsername = ""
    var computedremoteargs = ""
    var linkdestparam = ""
    var sharedpathforrestore = ""

    var snapshotnum = -1
    var rsyncdaemon = -1

    var rsyncversion3 = false
    
    public init(task: String,
                parameter1: String,
                parameter2: String,
                parameter3: String,
                parameter4: String,
                parameter8: String?,
                parameter9: String?,
                parameter10: String?,
                parameter11: String?,
                parameter12: String?,
                parameter13: String?,
                parameter14: String?,
                sshport: String?,
                sshkeypathandidentityfile: String?,
                sharedsshport: String?,
                sharedsshkeypathandidentityfile: String?,
                localCatalog: String,
                offsiteCatalog: String,
                offsiteServer: String,
                offsiteUsername: String,
                sharedpathforrestore: String,
                snapshotnum: Int,
                rsyncdaemon: Int,
                rsyncversion3: Bool)
    {
        self.task = task
        self.parameter1 = parameter1
        self.parameter2 = parameter2
        self.parameter3 = parameter3
        self.parameter4 = parameter4
        self.parameter8 = parameter8
        self.parameter9 = parameter9
        self.parameter10 = parameter10
        self.parameter11 = parameter11
        self.parameter12 = parameter12
        self.parameter13 = parameter13
        self.parameter14 = parameter14
        self.sshport = sshport
        self.sshkeypathandidentityfile = sshkeypathandidentityfile
        self.sharedsshport = sharedsshport
        self.sharedsshkeypathandidentityfile = sharedsshkeypathandidentityfile
        self.localCatalog = localCatalog
        self.offsiteCatalog = offsiteCatalog
        self.offsiteServer = offsiteServer
        self.offsiteUsername = offsiteUsername
        self.sharedpathforrestore = sharedpathforrestore
        self.snapshotnum = snapshotnum
        self.rsyncdaemon = rsyncdaemon
        self.rsyncversion3 = rsyncversion3
    }
}
