//
//  RsyncParametersRestore.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 07/08/2024.
//

import Foundation

@MainActor
public final class RsyncParametersRestore {
    public private(set) var computedarguments = [String]()

    var task = ""

    var parameter1 = ""
    var parameter2 = ""
    var parameter3 = ""
    var parameter4 = ""
    var parameter5 = ""
    var parameter6 = ""

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

    public func initialise_rsyncparameters(forDisplay: Bool, verify: Bool, dryrun: Bool) {
        let rsyncparameters1to6 = RsyncParameters1to6(parameter1: parameter1,
                                                      parameter2: parameter2,
                                                      parameter3: parameter3,
                                                      parameter4: parameter4,
                                                      parameter5: parameter5,
                                                      parameter6: parameter6,
                                                      offsiteServer: offsiteServer,
                                                      sshport: sshport,
                                                      sshkeypathandidentityfile: sshkeypathandidentityfile,
                                                      sharedsshport: sharedsshport,
                                                      sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
                                                      rsyncversion3: rsyncversion3)

        computedarguments += rsyncparameters1to6.setParameters1To6(forDisplay: forDisplay, verify: verify)

        let rsyncparameters8to14 = RsyncParameters8to14(parameter8: parameter8,
                                                        parameter9: parameter9,
                                                        parameter10: parameter10,
                                                        parameter11: parameter11,
                                                        parameter12: parameter12,
                                                        parameter13: parameter13,
                                                        parameter14: parameter14,
                                                        rsyncversion3: rsyncversion3)

        computedarguments += rsyncparameters8to14.setParameters8To14(dryRun: dryrun, forDisplay: forDisplay)
    }

    public func initialise_sshparametersonly(forDisplay: Bool, verify: Bool) {
        let sshparametersonly = RsyncParametersSSHandSSHPORT(
            parameter5: parameter5,
            parameter6: parameter6,
            offsiteServer: offsiteServer,
            sshport: sshport,
            sshkeypathandidentityfile: sshkeypathandidentityfile,
            sharedsshport: sharedsshport,
            sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
            rsyncversion3: rsyncversion3
        )

        computedarguments += sshparametersonly.setParameters1SSHandSSHPORT(forDisplay: forDisplay, verify: verify)
    }

    public func remoteargumentsfilelist() {
        guard offsiteServer.isEmpty == false else { return }
        computedarguments.append(DefaultRsyncParameters.verbose_parameter2.rawValue)
        computedarguments.append(DefaultRsyncParameters.compress_parameter3.rawValue)
        computedarguments.append("-r")
        computedarguments.append("--list-only")
        initialise_sshparametersonly(forDisplay: false, verify: false)
        computedarguments.append(remoteargs())
    }

    public func remoteargumentssnapshotcataloglist() {
        guard rsyncversion3 == true else { return }
        guard offsiteServer.isEmpty == false else { return }
        computedarguments.append(DefaultRsyncParameters.verbose_parameter2.rawValue)
        computedarguments.append(DefaultRsyncParameters.compress_parameter3.rawValue)
        computedarguments.append("--list-only")
        initialise_sshparametersonly(forDisplay: false, verify: false)
        computedarguments.append(remoteargs())
    }

    // Retrive files within ONE snapshotcatalog
    public func remoteargumentssnapshotfilelist() {
        guard rsyncversion3 == true else { return }
        guard offsiteServer.isEmpty == false else { return }
        computedarguments.append(DefaultRsyncParameters.verbose_parameter2.rawValue)
        computedarguments.append(DefaultRsyncParameters.compress_parameter3.rawValue)
        computedarguments.append("-r")
        computedarguments.append("--list-only")
        initialise_sshparametersonly(forDisplay: false, verify: false)
        computedarguments.append(remoteargssnapshot())
    }

    private func remoteargs() -> String {
        if rsyncdaemon == 1 {
            computedremoteargs = offsiteUsername + "@" + offsiteServer + "::" + offsiteCatalog
        } else {
            computedremoteargs = offsiteUsername + "@" + offsiteServer + ":" + offsiteCatalog
        }
        return computedremoteargs
    }

    private func remoteargssnapshot() -> String {
        offsiteCatalog += String(snapshotnum - 1) + "/"
        if rsyncdaemon == 1 {
            computedremoteargs = offsiteUsername + "@" + offsiteServer + "::" + offsiteCatalog
        } else {
            computedremoteargs = offsiteUsername + "@" + offsiteServer + ":" + offsiteCatalog
        }
        return computedremoteargs
    }

    public func argumentsrestore(forDisplay: Bool, verify: Bool, dryrun: Bool, restoresnapshotbyfiles: Bool) {
        // Restore only for synchronize and snapshottasks
        guard task != DefaultRsyncParameters.syncremote.rawValue else { return }
        guard offsiteServer.isEmpty == false else { return }
        guard sharedpathforrestore.isEmpty == false else { return }

        computedarguments.append(DefaultRsyncParameters.archive_parameter1.rawValue)
        computedarguments.append(DefaultRsyncParameters.verbose_parameter2.rawValue)
        computedarguments.append(DefaultRsyncParameters.compress_parameter3.rawValue)

        // Must add --dryrun here, normally it is appended in syncparameters8to14
        // Only parameters 1to6 are added for getting remote filelists
        if dryrun {
            computedarguments.append(DefaultRsyncParameters.dryrun.rawValue)
            if forDisplay { computedarguments.append(" ") }
        }
        computedarguments.append("--stats")

        initialise_sshparametersonly(forDisplay: forDisplay, verify: verify)

        let snapshot: Bool = snapshotnum != -1 ? true : false
        if snapshot {
            if restoresnapshotbyfiles == true {
                // This is a hack for fixing correct restore for files
                // from a snapshot. The last snapshot is base for restore
                // of files. The correct snapshot is added within the
                // ObserveableRestore which is used within the RestoreView
                // --archive --verbose --compress --delete -e "ssh -i ~/.ssh_rsyncosx/rsyncosx -p 22"
                // --exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt --dry-run --stats
                // thomas@backup:/backups/snapshots/Github/85/AlertToast /Users/thomas/tmp
                if forDisplay { computedarguments.append(" ") }
                computedarguments.append(remoteargs())
                if forDisplay { computedarguments.append(" ") }
            } else {
                // --archive --verbose --compress --delete -e "ssh -i ~/.ssh_rsyncosx/rsyncosx -p 22"
                // --exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt --dry-run --stats
                // thomas@backup:/backups/snapshots/Github/85/ /Users/thomas/tmp
                if forDisplay { computedarguments.append(" ") }
                computedarguments.append(remoteargssnapshot())
                if forDisplay { computedarguments.append(" ") }
            }
        } else {
            if forDisplay { computedarguments.append(" ") }
            computedarguments.append(remoteargs())
            if forDisplay { computedarguments.append(" ") }
        }
        computedarguments.append(sharedpathforrestore)
    }

    public init(task: String,
                parameter1: String,
                parameter2: String,
                parameter3: String,
                parameter4: String,
                parameter5: String,
                parameter6: String,
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
        self.parameter5 = parameter5
        self.parameter6 = parameter6
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
        
        // Some checks for sshport and sshkeypathandidentityfile
        
        if sshport == "-1" {
            // Reset values to nil
            self.sshport = nil
            self.sshkeypathandidentityfile = nil
        }
        
        if sharedsshport == "-1" {
            // Reset values to nil
            self.sharedsshport = nil
            self.sharedsshkeypathandidentityfile = nil
        }
        
        computedarguments.removeAll()
    }
}
