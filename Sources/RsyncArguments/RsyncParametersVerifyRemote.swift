//
//  RsyncParametersVerifyRemote.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 13/11/2024.
//

import Foundation

@MainActor
public final class RsyncParametersVerifyRemote {
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

    public func initialise_sshparametersonly(forDisplay: Bool, verify: Bool) {
        let sshparametersonly = RsyncParametersSSHandSSHPORT(
            offsiteServer: offsiteServer,
            sshport: sshport,
            sshkeypathandidentityfile: sshkeypathandidentityfile,
            sharedsshport: sharedsshport,
            sharedsshkeypathandidentityfile: sharedsshkeypathandidentityfile,
            rsyncversion3: rsyncversion3
        )

        computedarguments += sshparametersonly.setParametersSSHandSSHPORT(forDisplay: forDisplay, verify: verify)
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

    public func argumentsverifyremote(forDisplay: Bool, verify: Bool, dryrun: Bool) {
        // Verify only for synchronize tasks
        guard task != DefaultRsyncParameters.syncremote.rawValue else { return }
        guard task != DefaultRsyncParameters.snapshot.rawValue else { return }
        guard offsiteServer.isEmpty == false else { return }

        computedarguments.append(DefaultRsyncParameters.archive_parameter1.rawValue)
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(DefaultRsyncParameters.verbose_parameter2.rawValue)
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(DefaultRsyncParameters.compress_parameter3.rawValue)
        if forDisplay { computedarguments.append(" ") }

        // Must add --dryrun here, normally it is appended in syncparameters8to14
        if dryrun {
            computedarguments.append(DefaultRsyncParameters.dryrun.rawValue)
            if forDisplay { computedarguments.append(" ") }
        }
        computedarguments.append("--stats")
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append("--exclude=.git/")
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append("--exclude=.DS_Store")
        if forDisplay { computedarguments.append(" ") }
        
        initialise_sshparametersonly(forDisplay: forDisplay, verify: verify)
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(remoteargs())
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(localCatalog)
    }
    
    public func argumentsverifyremotewithparameters(forDisplay: Bool, verify: Bool, dryrun: Bool, nodelete: Bool) {
        // Verify only for synchronize tasks
        guard task != DefaultRsyncParameters.syncremote.rawValue else { return }
        guard task != DefaultRsyncParameters.snapshot.rawValue else { return }
        guard offsiteServer.isEmpty == false else { return }

        initialise_rsyncparameters(forDisplay: forDisplay, verify: verify, dryrun: dryrun)
        if nodelete {
            computedarguments.removeAll { argument in
                argument.hasPrefix("--delete")
            }
        }
        
        computedarguments.append("--exclude=.git/")
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append("--exclude=.DS_Store")
        if forDisplay { computedarguments.append(" ") }
        
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(remoteargs())
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append(localCatalog)
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
