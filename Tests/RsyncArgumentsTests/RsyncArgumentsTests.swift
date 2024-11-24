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
    
    init(testconfigurations: [TestSynchronizeConfiguration]? = nil, nr0: [String]? = nil, nr1: [String]? = nil, nr2: [String]? = nil, nr3: [String]? = nil, nr4: [String]? = nil, nr5: [String]? = nil) async {
        self.testconfigurations = testconfigurations
        self.nr0 = nr0
        self.nr1 = nr1
        self.nr2 = nr2
        self.nr3 = nr3
        self.nr4 = nr4
        self.nr5 = nr5
        
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        self.testconfigurations = loadtestdata.testconfigurations
    }

    @Test func LodaDataTestSynchronize() async {
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let parameters = await Parameters(task: testconfigurations[i].task,
                                                  parameter1: testconfigurations[i].parameter1,
                                                  parameter2: testconfigurations[i].parameter2,
                                                  parameter3: testconfigurations[i].parameter3,
                                                  parameter4: testconfigurations[i].parameter4,
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
                                                  rsyncdaemon: testconfigurations[i].rsyncdaemon ?? -1,
                                                  rsyncversion3: TestSharedReference.shared.rsyncversion3)
                let rsyncparameterssynchronize = await RsyncParametersSynchronize(parameters: parameters)
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

@Suite final class TestRestoreFilelist {
    var testconfigurations: [TestSynchronizeConfiguration]?
    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    
    init(testconfigurations: [TestSynchronizeConfiguration]? = nil, nr0: [String]? = nil, nr1: [String]? = nil, nr2: [String]? = nil, nr3: [String]? = nil) async {
        self.testconfigurations = testconfigurations
        self.nr0 = nr0
        self.nr1 = nr1
        self.nr2 = nr2
        self.nr3 = nr3
        
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        self.testconfigurations = loadtestdata.testconfigurations
    }

    @Test func LodaDataTestRestore() async {
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let parameters = await Parameters(task: testconfigurations[i].task,
                                                  parameter1: testconfigurations[i].parameter1,
                                                  parameter2: testconfigurations[i].parameter2,
                                                  parameter3: testconfigurations[i].parameter3,
                                                  parameter4: testconfigurations[i].parameter4,
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
                                                  rsyncdaemon: testconfigurations[i].rsyncdaemon ?? -1,
                                                  rsyncversion3: TestSharedReference.shared.rsyncversion3)
                let rsyncparametersrestore = await RsyncParametersRestore(parameters: parameters)
                switch testconfigurations[i].task {
                case TestSharedReference.shared.synchronize:
                    print("SYNCHRONIZE filelist")
                    await rsyncparametersrestore.remoteargumentsfilelist()
                case TestSharedReference.shared.snapshot:
                    print("SNAPSHOT filelist")
                    await rsyncparametersrestore.remoteargumentssnapshotcataloglist()
                default:
                    break
                }

                switch i {
                case 0:
                    print("Assigned first arguments RESTORE filelist")
                    nr0 = await rsyncparametersrestore.computedarguments
                    #expect(ArgumentsRestoreFilelist().nr0 == nr0)
                case 1:
                    print("Assigned second arguments RESTORE filelist")
                    nr1 = await rsyncparametersrestore.computedarguments
                    #expect(ArgumentsRestoreFilelist().nr1 == nr1)
                case 2:
                    print("Assigned third arguments RESTORE filelist")
                    nr2 = await rsyncparametersrestore.computedarguments
                    #expect(ArgumentsRestoreFilelist().nr2 == nr2)
                case 3:
                    print("Assigned fourth arguments RESTORE filelist")
                    nr3 = await rsyncparametersrestore.computedarguments
                    #expect(ArgumentsRestoreFilelist().nr3 == nr3)
                case 4:
                    print("Assigned fifth arguments RESTORE filelist")
                    let arguments = await rsyncparametersrestore.computedarguments
                    #expect(arguments.isEmpty == true)
                case 5:
                    print("Assigned sixth arguments RESTORE filelist")
                    let arguments = await rsyncparametersrestore.computedarguments
                    #expect(arguments.isEmpty == true)
                default:
                    print("Assigned NO arguments RESTORE")
                    return
                }
            }
        }
    }
}

@Suite final class TestRestoreFiles {
    var testconfigurations: [TestSynchronizeConfiguration]?
    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    
    init(testconfigurations: [TestSynchronizeConfiguration]? = nil, nr0: [String]? = nil, nr1: [String]? = nil, nr2: [String]? = nil, nr3: [String]? = nil) async {
        self.testconfigurations = testconfigurations
        self.nr0 = nr0
        self.nr1 = nr1
        self.nr2 = nr2
        self.nr3 = nr3
        
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        self.testconfigurations = loadtestdata.testconfigurations
    }

    @Test func LodaDataTestRestoreFiles() async {
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let parameters = await Parameters(task: testconfigurations[i].task,
                                                  parameter1: testconfigurations[i].parameter1,
                                                  parameter2: testconfigurations[i].parameter2,
                                                  parameter3: testconfigurations[i].parameter3,
                                                  parameter4: testconfigurations[i].parameter4,
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
                                                  rsyncdaemon: testconfigurations[i].rsyncdaemon ?? -1,
                                                  rsyncversion3: TestSharedReference.shared.rsyncversion3)
                let rsyncparametersrestorefiles = await RsyncParametersRestore(parameters: parameters)
                await rsyncparametersrestorefiles.argumentsrestore(forDisplay: false, verify: false, dryrun: true, restoresnapshotbyfiles: false)

                switch i {
                case 0:
                    print("Assigned first arguments RESTORE")
                    nr0 = await rsyncparametersrestorefiles.computedarguments
                    #expect(ArgumentsRestore().nr0 == nr0)
                case 1:
                    print("Assigned second arguments RESTORE")
                    nr1 = await rsyncparametersrestorefiles.computedarguments
                    #expect(ArgumentsRestore().nr1 == nr1)
                case 2:
                    print("Assigned third arguments RESTORE")
                    nr2 = await rsyncparametersrestorefiles.computedarguments
                    #expect(ArgumentsRestore().nr2 == nr2)
                case 3:
                    print("Assigned fourth arguments RESTORE")
                    nr3 = await rsyncparametersrestorefiles.computedarguments
                    #expect(ArgumentsRestore().nr3 == nr3)
                case 4:
                    print("Assigned fifth arguments RESTORE")
                    let arguments = await rsyncparametersrestorefiles.computedarguments
                    #expect(arguments.isEmpty == true)
                case 5:
                    print("Assigned sixth arguments RESTORE")
                    let arguments = await rsyncparametersrestorefiles.computedarguments
                    #expect(arguments.isEmpty == true)
                default:
                    print("Assigned NO arguments RESTORE")
                    return
                }
            }
        }
    }
}

@Suite final class TestDeleteSnapshot {
    var testconfigurations: [TestSynchronizeConfiguration]?

    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    var nr4: [String]?
    var nr5: [String]?
    
    init(testconfigurations: [TestSynchronizeConfiguration]? = nil, nr0: [String]? = nil, nr1: [String]? = nil, nr2: [String]? = nil, nr3: [String]? = nil, nr4: [String]? = nil, nr5: [String]? = nil) async {
        self.testconfigurations = testconfigurations
        self.nr0 = nr0
        self.nr1 = nr1
        self.nr2 = nr2
        self.nr3 = nr3
        self.nr4 = nr4
        self.nr5 = nr5
        
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        self.testconfigurations = loadtestdata.testconfigurations
    }

    @Test func LodaDataSSHCommands() async {
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let sshparameters = await SSHParameters(offsiteServer: testconfigurations[i].offsiteServer,
                                                        offsiteUsername: testconfigurations[i].offsiteUsername,
                                                        sshport: String(testconfigurations[i].sshport ?? -1),
                                                        sshkeypathandidentityfile: testconfigurations[i].sshkeypathandidentityfile ?? "",
                                                        sharedsshport: String(TestSharedReference.shared.sshport ?? -1),
                                                        sharedsshkeypathandidentityfile: TestSharedReference.shared.sshkeypathandidentityfile,
                                                        rsyncversion3: TestSharedReference.shared.rsyncversion3)

                let sshcommands = await SnapshotDelete(sshparameters: sshparameters)
                await sshcommands.initialise_setsshidentityfileandsshport()

                switch i {
                case 0:
                    print("Assigned first arguments Delete snapshot")
                    let nr0 = await sshcommands.snapshotdelete(remotecatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr0 == nr0)
                case 1:
                    print("Assigned second arguments Delete snapshot")
                    let nr1 = await sshcommands.snapshotdelete(remotecatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr1 == nr1)
                case 2:
                    print("Assigned third arguments Delete snapshot")
                    let nr2 = await sshcommands.snapshotdelete(remotecatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr2 == nr2)
                case 3:
                    print("Assigned fourth arguments Delete snapshot")
                    let nr3 = await sshcommands.snapshotdelete(remotecatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr3 == nr3)
                case 4:
                    print("Assigned fifth arguments Delete snapshot")
                    let nr4 = await sshcommands.snapshotdelete(remotecatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr4 == nr4)
                case 5:
                    print("Assigned sixth arguments Delete snapshot")
                    let nr5 = await sshcommands.snapshotdelete(remotecatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr5 == nr5)
                default:
                    print("Assigned NO arguments Delete snapshot")
                    return
                }
            }
        }
    }
}

@Suite final class TestSynchronizeNOSSH {
    var testconfigurations: [TestSynchronizeConfiguration]?
    // Save computed parameters
    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    var nr4: [String]?
    var nr5: [String]?
    
    init(testconfigurations: [TestSynchronizeConfiguration]? = nil, nr0: [String]? = nil, nr1: [String]? = nil, nr2: [String]? = nil, nr3: [String]? = nil, nr4: [String]? = nil, nr5: [String]? = nil) async {
        self.testconfigurations = testconfigurations
        self.nr0 = nr0
        self.nr1 = nr1
        self.nr2 = nr2
        self.nr3 = nr3
        self.nr4 = nr4
        self.nr5 = nr5
        
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdatanossh()
        self.testconfigurations = loadtestdata.testconfigurations
    }

    @Test func LodaDataTestSynchronize() async {
        
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let parameters = await Parameters(task: testconfigurations[i].task,
                                                  parameter1: testconfigurations[i].parameter1,
                                                  parameter2: testconfigurations[i].parameter2,
                                                  parameter3: testconfigurations[i].parameter3,
                                                  parameter4: testconfigurations[i].parameter4,
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
                                                  rsyncdaemon: testconfigurations[i].rsyncdaemon ?? -1,
                                                  rsyncversion3: TestSharedReference.shared.rsyncversion3)
                let rsyncparameterssynchronize = await RsyncParametersSynchronize(parameters: parameters)
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
                    print("Assigned first arguments NOSSH SYNCHRONIZE")
                    nr0 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronizeNOSSH().nr0 == nr0)
                case 1:
                    print("Assigned second arguments NOSSH SYNCHRONIZE")
                    nr1 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronizeNOSSH().nr1 == nr1)
                case 2:
                    print("Assigned third arguments NOSSH SYNCHRONIZE")
                    nr2 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronizeNOSSH().nr2 == nr2)
                case 3:
                    print("Assigned fourth arguments NOSSH SYNCHRONIZE")
                    nr3 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronizeNOSSH().nr3 == nr3)
                case 4:
                    print("Assigned fifth arguments NOSSH SYNCHRONIZE")
                    nr4 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronizeNOSSH().nr4 == nr4)
                case 5:
                    print("Assigned sixth arguments NOSSH SYNCHRONIZE")
                    nr5 = await rsyncparameterssynchronize.computedarguments
                    #expect(ArgumentsSynchronizeNOSSH().nr5 == nr5)
                default:
                    print("Assigned NO arguments NOSSH SYNCHRONIZE")
                    return
                }
            }
        }
    }
}

@Suite final class TestPull{
    var testconfigurations: [TestSynchronizeConfiguration]?
    // Save computed parameters
    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    var nr4: [String]?
    var nr5: [String]?
    
    init(testconfigurations: [TestSynchronizeConfiguration]? = nil, nr0: [String]? = nil, nr1: [String]? = nil, nr2: [String]? = nil, nr3: [String]? = nil, nr4: [String]? = nil, nr5: [String]? = nil) async {
        self.testconfigurations = testconfigurations
        self.nr0 = nr0
        self.nr1 = nr1
        self.nr2 = nr2
        self.nr3 = nr3
        self.nr4 = nr4
        self.nr5 = nr5
        
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        // Only pick the right task for testing
        self.testconfigurations = loadtestdata.testconfigurations.compactMap({ configuration in
            return (configuration.task == "synchronize" && configuration.offsiteServer.isEmpty == false) ? configuration : nil
        })
    }

    @Test func LodaDataTestSynchronize() async {
        
        if let testconfigurations {
            // It are THREE test configurations for pull and push
            for i in 0 ..< testconfigurations.count {
                let parameters = await Parameters(task: testconfigurations[i].task,
                                                  parameter1: testconfigurations[i].parameter1,
                                                  parameter2: testconfigurations[i].parameter2,
                                                  parameter3: testconfigurations[i].parameter3,
                                                  parameter4: testconfigurations[i].parameter4,
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
                                                  rsyncdaemon: testconfigurations[i].rsyncdaemon ?? -1,
                                                  rsyncversion3: TestSharedReference.shared.rsyncversion3)
                
                let rsyncparameterspull = await RsyncParametersPullRemote(parameters: parameters)
            
                await rsyncparameterspull.argumentspullremotewithparameters(forDisplay: false, verify: false, dryrun: true)
                
                switch i {
                case 0:
                    print("Assigned first arguments PUSH")
                    nr0 = await rsyncparameterspull.computedarguments
                    #expect(ArgumentsPull().nr0 == nr0)
                case 1:
                    print("Assigned second arguments PUSH")
                    nr1 = await rsyncparameterspull.computedarguments
                    #expect(ArgumentsPull().nr1 == nr1)
                case 2:
                    print("Assigned third arguments PUSH")
                    nr2 = await rsyncparameterspull.computedarguments
                    #expect(ArgumentsPull().nr2 == nr2)
                default:
                    print("Assigned NO arguments PUSH")
                    return
                }
            }
        }
    }
}

@Suite final class TestPush {
    var testconfigurations: [TestSynchronizeConfiguration]?
    // Save computed parameters
    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    var nr4: [String]?
    var nr5: [String]?
    
    init(testconfigurations: [TestSynchronizeConfiguration]? = nil, nr0: [String]? = nil, nr1: [String]? = nil, nr2: [String]? = nil, nr3: [String]? = nil, nr4: [String]? = nil, nr5: [String]? = nil) async {
        self.testconfigurations = testconfigurations
        self.nr0 = nr0
        self.nr1 = nr1
        self.nr2 = nr2
        self.nr3 = nr3
        self.nr4 = nr4
        self.nr5 = nr5
        
        let loadtestdata = ReadTestdataFromGitHub()
        await loadtestdata.getdata()
        // Only pick the right task for testing
        self.testconfigurations = loadtestdata.testconfigurations.compactMap({ configuration in
            return (configuration.task == "synchronize" && configuration.offsiteServer.isEmpty == false) ? configuration : nil
        })
    }

    @Test func LodaDataTestSynchronize() async {
        
        if let testconfigurations {
            // It are THREE test configurations for pull and push
            for i in 0 ..< testconfigurations.count {
                let parameters = await Parameters(task: testconfigurations[i].task,
                                                  parameter1: testconfigurations[i].parameter1,
                                                  parameter2: testconfigurations[i].parameter2,
                                                  parameter3: testconfigurations[i].parameter3,
                                                  parameter4: testconfigurations[i].parameter4,
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
                                                  rsyncdaemon: testconfigurations[i].rsyncdaemon ?? -1,
                                                  rsyncversion3: TestSharedReference.shared.rsyncversion3)
                
                let rsyncparameterpush = await RsyncParametersSynchronize(parameters: parameters)
                await rsyncparameterpush.argumentsforpushlocaltoremote(forDisplay: false, verify: false, dryrun: true)
                
                switch i {
                case 0:
                    print("Assigned first arguments PULL")
                    nr0 = await rsyncparameterpush.computedarguments
                    #expect(ArgumentsPush().nr0 == nr0)
                case 1:
                    print("Assigned second arguments PULL")
                    nr1 = await rsyncparameterpush.computedarguments
                    #expect(ArgumentsPush().nr1 == nr1)
                case 2:
                    print("Assigned third arguments PULL")
                    nr2 = await rsyncparameterpush.computedarguments
                    #expect(ArgumentsPush().nr2 == nr2)
                default:
                    print("Assigned NO arguments PULL")
                    return
                }
            }
        }
    }
}

