@testable import RsyncArguments
import Testing

@Suite final class TestSynchronize {
    var testconfigurations: [TestSynchronizeConfiguration]?

    @Test func LodaData() async {
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        testconfigurations = loadtestdata.testconfigurations
        if let testconfigurations {
            for i in 0 ..< testconfigurations.count {
                let rsyncparameterscompute = await RsyncParametersCompute(task: testconfigurations[i].task,
                                                                          parameter1: testconfigurations[i].parameter1,
                                                                          parameter2: testconfigurations[i].parameter2,
                                                                          parameter3: testconfigurations[i].parameter3,
                                                                          parameter4: testconfigurations[i].parameter4,
                                                                          parameter5: testconfigurations[i].parameter5,
                                                                          parameter6: testconfigurations[i].parameter5,
                                                                          parameter8: testconfigurations[i].parameter8,
                                                                          parameter9: testconfigurations[i].parameter9,
                                                                          parameter10: testconfigurations[i].parameter10,
                                                                          parameter11: testconfigurations[i].parameter11,
                                                                          parameter12: testconfigurations[i].parameter12,
                                                                          parameter13: testconfigurations[i].parameter13,
                                                                          parameter14: testconfigurations[i].parameter14,
                                                                          sshport: String(testconfigurations[i].sshport ?? -1),
                                                                          sshkeypathandidentityfile: testconfigurations[i].sshkeypathandidentityfile ?? "",
                                                                          sharedsshport: String(TestSharedReference.shared.sshport ?? -1),
                                                                          sharedsshkeypathandidentityfile: TestSharedReference.shared.sshkeypathandidentityfile,
                                                                          localCatalog: testconfigurations[i].localCatalog,
                                                                          offsiteCatalog: testconfigurations[i].offsiteCatalog,
                                                                          offsiteServer: testconfigurations[i].offsiteServer,
                                                                          offsiteUsername: testconfigurations[i].offsiteUsername,
                                                                          sharedpathforrestore: TestSharedReference.shared.pathforrestore ?? "",
                                                                          snapshotnum: testconfigurations[i].snapshotnum ?? -1,
                                                                          rsyncdaemon: testconfigurations[i].rsyncdaemon ?? -1)
                switch testconfigurations[i].task {
                case TestSharedReference.shared.synchronize:
                    await rsyncparameterscompute.argumentsforsynchronize(forDisplay: false, verify: false, dryrun: true)
                case TestSharedReference.shared.snapshot:
                    await rsyncparameterscompute.argumentsforsynchronizesnapshot(forDisplay: false, verify: false, dryrun: true)
                case TestSharedReference.shared.syncremote:
                    await rsyncparameterscompute.argumentsforsynchronizeremote(forDisplay: false, verify: false, dryrun: true)
                default:
                    break
                }
            }
        }
    }
}
