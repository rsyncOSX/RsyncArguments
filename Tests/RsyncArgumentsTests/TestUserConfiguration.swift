//
//  TestUserConfiguration.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 05/08/2024.
//

import Foundation

struct TestUserConfiguration: Codable {
    var rsyncversion3: Int = -1
    // Detailed logging
    var addsummarylogrecord: Int = 1
    // Montor network connection
    var monitornetworkconnection: Int = -1
    // local path for rsync
    var localrsyncpath: String?
    // temporary path for restore
    var pathforrestore: String?
    // days for mark days since last synchronize
    var marknumberofdayssince: String = "5"
    // Global ssh keypath and port
    var sshkeypathandidentityfile: String?
    var sshport: Int?
    // Environment variable
    var environment: String?
    var environmentvalue: String?
    // Check for error in output from rsync
    var checkforerrorinrsyncoutput: Int = -1
    // Automatic execution
    var confirmexecute: Int?

    @MainActor private func setuserconfigdata() {
        TestSharedReference.shared.rsyncversion3 = rsyncversion3 == 1
        TestSharedReference.shared.addsummarylogrecord = addsummarylogrecord == 1
        TestSharedReference.shared.monitornetworkconnection = monitornetworkconnection == 1
        TestSharedReference.shared.localrsyncpath = localrsyncpath
        TestSharedReference.shared.pathforrestore = pathforrestore
        if Int(marknumberofdayssince) ?? 0 > 0 {
            TestSharedReference.shared.marknumberofdayssince = Int(marknumberofdayssince) ?? 0
        }
        TestSharedReference.shared.sshkeypathandidentityfile = sshkeypathandidentityfile
        TestSharedReference.shared.sshport = sshport
        TestSharedReference.shared.environment = environment
        TestSharedReference.shared.environmentvalue = environmentvalue
        TestSharedReference.shared.checkforerrorinrsyncoutput = checkforerrorinrsyncoutput == 1
        TestSharedReference.shared.confirmexecute = confirmexecute == 1
    }

    // Used when reading JSON data from store
    @discardableResult
    @MainActor init(_ data: DecodeTestUserConfiguration) {
        rsyncversion3 = data.rsyncversion3 ?? -1
        addsummarylogrecord = data.addsummarylogrecord ?? 1
        monitornetworkconnection = data.monitornetworkconnection ?? -1
        localrsyncpath = data.localrsyncpath
        pathforrestore = data.pathforrestore
        marknumberofdayssince = data.marknumberofdayssince ?? "5"
        sshkeypathandidentityfile = data.sshkeypathandidentityfile
        sshport = data.sshport
        environment = data.environment
        environmentvalue = data.environmentvalue
        checkforerrorinrsyncoutput = data.checkforerrorinrsyncoutput ?? -1
        confirmexecute = data.confirmexecute ?? -1
        // Set user configdata read from permanent store
        setuserconfigdata()
    }

    private func boolToInt(_ value: Bool) -> Int {
        value ? 1 : -1
    }

    // Default values user configuration
    @discardableResult
    @MainActor init() {
        rsyncversion3 = boolToInt(TestSharedReference.shared.rsyncversion3)
        addsummarylogrecord = boolToInt(TestSharedReference.shared.addsummarylogrecord)
        monitornetworkconnection = boolToInt(TestSharedReference.shared.monitornetworkconnection)
        localrsyncpath = TestSharedReference.shared.localrsyncpath
        pathforrestore = TestSharedReference.shared.pathforrestore
        marknumberofdayssince = String(TestSharedReference.shared.marknumberofdayssince)
        sshkeypathandidentityfile = TestSharedReference.shared.sshkeypathandidentityfile
        sshport = TestSharedReference.shared.sshport
        environment = TestSharedReference.shared.environment
        environmentvalue = TestSharedReference.shared.environmentvalue
        checkforerrorinrsyncoutput = boolToInt(TestSharedReference.shared.checkforerrorinrsyncoutput)
        confirmexecute = boolToInt(TestSharedReference.shared.confirmexecute)
    }
}
