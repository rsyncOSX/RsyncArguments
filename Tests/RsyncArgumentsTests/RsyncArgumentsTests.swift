@testable import RsyncArguments
import Testing

@Suite final class TestSynchronize {
    var testconfigurations: [TestSynchronizeConfiguration]?
    // Save computed parameters
    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    var nr4: [String]?
    var nr5: [String]?

    @Test func LodaData() async {
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        testconfigurations = loadtestdata.testconfigurations
        if let testconfigurations {
            // It are six test configurations
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
                    print("SYNCHRONIZE")
                    await rsyncparameterscompute.argumentsforsynchronize(forDisplay: false, verify: false, dryrun: true)
                case TestSharedReference.shared.snapshot:
                    print("SNAPSHOT")
                    await rsyncparameterscompute.argumentsforsynchronizesnapshot(forDisplay: false, verify: false, dryrun: true)
                case TestSharedReference.shared.syncremote:
                    print("SYNCREMOTE")
                    await rsyncparameterscompute.argumentsforsynchronizeremote(forDisplay: false, verify: false, dryrun: true)
                default:
                    break
                }

                switch i {
                case 0:
                    print("Assigned first arguments")
                    nr0 = await rsyncparameterscompute.computedarguments
                    #expect(ArgumentsSynchronize().nr0 == nr0)
                case 1:
                    print("Assigned second arguments")
                    nr1 = await rsyncparameterscompute.computedarguments
                    #expect(ArgumentsSynchronize().nr1 == nr1)
                case 2:
                    print("Assigned third arguments")
                    nr2 = await rsyncparameterscompute.computedarguments
                    #expect(ArgumentsSynchronize().nr2 == nr2)
                case 3:
                    print("Assigned fourth arguments")
                    nr3 = await rsyncparameterscompute.computedarguments
                    #expect(ArgumentsSynchronize().nr3 == nr3)
                case 4:
                    print("Assigned fifth arguments")
                    nr4 = await rsyncparameterscompute.computedarguments
                    #expect(ArgumentsSynchronize().nr4 == nr4)
                case 5:
                    print("Assigned sixth arguments")
                    nr5 = await rsyncparameterscompute.computedarguments
                    #expect(ArgumentsSynchronize().nr5 == nr5)
                default:
                    print("Assigned NO arguments")
                    return
                }
            }
        }
    }
}
