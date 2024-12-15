//
//  RsyncParametersSynchronize.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 03/08/2024.
//

import Foundation

@MainActor
public final class RsyncParametersSynchronize {
    public private(set) var computedarguments = [String]()

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

    public func initialise_rsyncparameters(forDisplay: Bool, verify: Bool, dryrun: Bool) {
        let rsyncparameters1to4 = RsyncParameters1to4(parameter1: parameter1,
                                                      parameter2: parameter2,
                                                      parameter3: parameter3,
                                                      parameter4: parameter4,
                                                      offsiteServer: offsiteServer,
                                                      sshport: sshport,
                                                      sshkeypathandidentityfile: sshkeypathandidentityfile,
                                                      sharedsshport: sharedsshport,
                                                      sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
                                                      rsyncversion3: rsyncversion3)

        computedarguments += rsyncparameters1to4.setParameters1To4(forDisplay: forDisplay, verify: verify)

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

    public func argumentsforsynchronize(forDisplay: Bool, verify: Bool, dryrun: Bool) {
        guard task == DefaultRsyncParameters.synchronize.rawValue else { return }

        initialise_rsyncparameters(forDisplay: forDisplay, verify: verify, dryrun: dryrun)

        computedarguments.append(localCatalog)

        if offsiteServer.isEmpty == true {
            if forDisplay { computedarguments.append(" ") }
            computedarguments.append(offsiteCatalog)
            if forDisplay { computedarguments.append(" ") }
        } else {
            if forDisplay { computedarguments.append(" ") }
            computedarguments.append(remoteargs())
            if forDisplay { computedarguments.append(" ") }
        }
    }
    
    // This function is used in push and pull remote to check
    // if local data is updated or not.
    // arguments for --delete is deleted
    // arguments for --exclude=.git and --exclude=DS_Store are added
    
    public func argumentsforpushlocaltoremote(forDisplay: Bool, verify: Bool, dryrun: Bool) {
        
        // Verify only for synchronize tasks
        guard task != DefaultRsyncParameters.syncremote.rawValue else { return }
        guard task != DefaultRsyncParameters.snapshot.rawValue else { return }

        initialise_rsyncparameters(forDisplay: forDisplay, verify: verify, dryrun: dryrun)
        if let index = computedarguments.firstIndex(where: { $0 == "--delete" }) {
            computedarguments.remove(at: index)
        }
        if let index = computedarguments.firstIndex(where: { $0 == "--exclude=.git/" }) {
            computedarguments.remove(at: index)
        }
        if let index = computedarguments.firstIndex(where: { $0 == "--exclude=.DS_Store" }) {
            computedarguments.remove(at: index)
        }
        
        // Then add new arguments
        computedarguments.append("--update")
        if forDisplay { computedarguments.append(" ") }
        // Then add new arguments
        computedarguments.append("--itemize-changes")
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append("--exclude=.git/")
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append("--exclude=.DS_Store")
        if forDisplay { computedarguments.append(" ") }

        computedarguments.append(localCatalog)

        if offsiteServer.isEmpty == true {
            if forDisplay { computedarguments.append(" ") }
            computedarguments.append(offsiteCatalog)
            if forDisplay { computedarguments.append(" ") }
        } else {
            if forDisplay { computedarguments.append(" ") }
            computedarguments.append(remoteargs())
            if forDisplay { computedarguments.append(" ") }
        }
    }

    public func argumentsforsynchronizeremote(forDisplay: Bool, verify: Bool, dryrun: Bool) {
        guard task == DefaultRsyncParameters.syncremote.rawValue else { return }

        guard offsiteServer.isEmpty == false else { return }

        initialise_rsyncparameters(forDisplay: forDisplay, verify: verify, dryrun: dryrun)

        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(remoteargssyncremote())
        if forDisplay { computedarguments.append(" ") }

        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(offsiteCatalog)
        if forDisplay { computedarguments.append(" ") }
    }

    public func argumentsforsynchronizesnapshot(forDisplay: Bool, verify: Bool, dryrun: Bool) {
        guard task == DefaultRsyncParameters.snapshot.rawValue else { return }

        initialise_rsyncparameters(forDisplay: forDisplay, verify: verify, dryrun: dryrun)

        // Prepare linkdestparam and
        linkdestparameter(verify: verify)
        computedarguments.append(linkdestparam)
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(localCatalog)
        if forDisplay { computedarguments.append(" ") }

        if offsiteServer.isEmpty == true {
            if forDisplay { computedarguments.append(" ") }
            computedarguments.append(offsiteCatalog)
            if forDisplay { computedarguments.append(" ") }
        } else {
            if forDisplay { computedarguments.append(" ") }
            computedarguments.append(remoteargs())
            if forDisplay { computedarguments.append(" ") }
        }
    }

    private func remoteargs() -> String {
        if rsyncdaemon == 1 {
            computedremoteargs = offsiteUsername + "@" + offsiteServer + "::" + offsiteCatalog
        } else {
            computedremoteargs = offsiteUsername + "@" + offsiteServer + ":" + offsiteCatalog
        }
        return computedremoteargs
    }

    private func remoteargssyncremote() -> String {
        if rsyncdaemon == 1 {
            computedremoteargs = offsiteUsername + "@" + offsiteServer + "::" + localCatalog
        } else {
            computedremoteargs = offsiteUsername + "@" + offsiteServer + ":" + localCatalog
        }
        return computedremoteargs
    }

    // Additional parameters if snapshot
    private func linkdestparameter(verify: Bool) {
        linkdestparam = DefaultRsyncParameters.linkdest.rawValue + offsiteCatalog + String(snapshotnum - 1)
        if computedremoteargs.isEmpty == false {
            if verify {
                computedremoteargs += String(snapshotnum - 1)
            } else {
                computedremoteargs += String(snapshotnum)
            }
        }
        if verify {
            offsiteCatalog += String(snapshotnum - 1)
        } else {
            offsiteCatalog += String(snapshotnum)
        }
    }

    public init(parameters: Parameters) {
        task = parameters.task
        parameter1 = parameters.parameter1
        parameter2 = parameters.parameter2
        parameter3 = parameters.parameter3
        parameter4 = parameters.parameter4
        parameter8 = parameters.parameter8
        parameter9 = parameters.parameter9
        parameter10 = parameters.parameter10
        parameter11 = parameters.parameter11
        parameter12 = parameters.parameter12
        parameter13 = parameters.parameter13
        parameter14 = parameters.parameter14
        sshport = parameters.sshport
        sshkeypathandidentityfile = parameters.sshkeypathandidentityfile
        sharedsshport = parameters.sharedsshport
        sharedsshkeypathandidentityfile = parameters.sharedsshkeypathandidentityfile
        localCatalog = parameters.localCatalog
        offsiteCatalog = parameters.offsiteCatalog
        offsiteServer = parameters.offsiteServer
        offsiteUsername = parameters.offsiteUsername
        sharedpathforrestore = parameters.sharedpathforrestore
        snapshotnum = parameters.snapshotnum
        rsyncdaemon = parameters.rsyncdaemon
        rsyncversion3 = parameters.rsyncversion3

        computedarguments.removeAll()
    }
}
