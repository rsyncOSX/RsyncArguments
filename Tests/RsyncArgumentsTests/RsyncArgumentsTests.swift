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

    @Test func LodaDataTestSynchronize() async {
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        testconfigurations = loadtestdata.testconfigurations
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let rsyncparameterssynchronize = await RsyncParametersSynchronize(task: testconfigurations[i].task,
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
                    await rsyncparameterssynchronize.argumentsforsynchronize(forDisplay: false, verify: false, dryrun: true)
                case TestSharedReference.shared.snapshot:
                    print("SNAPSHOT")
                    await rsyncparameterssynchronize.argumentsforsynchronizesnapshot(forDisplay: false, verify: false, dryrun: true)
                case TestSharedReference.shared.syncremote:
                    print("SYNCREMOTE")
                    await rsyncparameterssynchronize.argumentsforsynchronizeremote(forDisplay: false, verify: false, dryrun: true)
                default:
                    break
                }

                switch i {
                case 0:
                    print("Assigned first arguments SYNCHRONIZE")
                    nr0 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronize().nr0 == nr0)
                case 1:
                    print("Assigned second arguments SYNCHRONIZE")
                    nr1 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronize().nr1 == nr1)
                case 2:
                    print("Assigned third arguments SYNCHRONIZE")
                    nr2 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronize().nr2 == nr2)
                case 3:
                    print("Assigned fourth arguments SYNCHRONIZE")
                    nr3 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronize().nr3 == nr3)
                case 4:
                    print("Assigned fifth arguments SYNCHRONIZE")
                    nr4 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronize().nr4 == nr4)
                case 5:
                    print("Assigned sixth arguments SYNCHRONIZE")
                    nr5 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronize().nr5 == nr5)
                default:
                    print("Assigned NO arguments SYNCHRONIZE")
                    return
                }
            }
        }
    }
}

@Suite final class TestRestore {
    var testconfigurations: [TestSynchronizeConfiguration]?
    
    @Test func LodaDataTestRestore() async {
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        testconfigurations = loadtestdata.testconfigurations
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let rsyncparametersrestore = await RsyncParametersRestore(task: testconfigurations[i].task,
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
                    print("SYNCHRONIZE filelist")
                    await rsyncparametersrestore.remoteargumentsfilelist(forDisplay: false, verify: false, dryrun: true, recursive: true)
                case TestSharedReference.shared.snapshot:
                    print("SNAPSHOT filelist")
                    await rsyncparametersrestore.remoteargumentssnapshotfilelist(forDisplay: false, verify: false, dryrun: true, recursive: false)
                default:
                    break
                }

                switch i {
                case 0:
                    print("Assigned first arguments RESTORE")
                    let arguments = await rsyncparametersrestore.computedarguments
                    print(arguments)
                case 1:
                    print("Assigned second arguments RESTORE")
                    let arguments = await rsyncparametersrestore.computedarguments
                    print(arguments)
                case 2:
                    print("Assigned third arguments RESTORE")
                    let arguments = await rsyncparametersrestore.computedarguments
                    print(arguments)
                case 3:
                    print("Assigned fourth arguments RESTORE")
                    let arguments = await rsyncparametersrestore.computedarguments
                    print(arguments)
                case 4:
                    print("Assigned fifth arguments RESTORE")
                    let arguments = await rsyncparametersrestore.computedarguments
                    print(arguments)
                case 5:
                    print("Assigned sixth arguments RESTORE")
                    let arguments = await rsyncparametersrestore.computedarguments
                    print(arguments)
                default:
                    print("Assigned NO arguments RESTORE")
                    return
                }
            }
        }
    }
    
}
