//
//  Parameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 23/09/2024.
//


public final class Parameters {
    public var task = ""
    
    public var parameter1 = ""
    public var parameter2 = ""
    public var parameter3 = ""
    public var parameter4 = ""

    public var parameter8: String?
    public var parameter9: String?
    public var parameter10: String?
    public var parameter11: String?
    public var parameter12: String?
    public var parameter13: String?
    public var parameter14: String?

    public var sshport: String?
    public var sshkeypathandidentityfile: String?
    public var sharedsshport: String?
    public var sharedsshkeypathandidentityfile: String?

    public var localCatalog = ""
    public var offsiteCatalog = ""
    public var offsiteServer = ""
    public var offsiteUsername = ""
    public var computedremoteargs = ""
    public var linkdestparam = ""
    public var sharedpathforrestore = ""

    public var snapshotnum = -1
    public var rsyncdaemon = -1

    public var rsyncversion3 = false
    
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
