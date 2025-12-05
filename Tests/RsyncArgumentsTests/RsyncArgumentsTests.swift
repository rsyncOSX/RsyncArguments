@testable import RsyncArguments
import Testing

@MainActor
@Suite final class TestSynchronize {
    var testconfigurations: [TestSynchronizeConfiguration]?
    // Save computed parameters
    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    var nr4: [String]?
    var nr5: [String]?

    init(testconfigurations: [TestSynchronizeConfiguration]? = nil,
         nr0: [String]? = nil,
         nr1: [String]? = nil,
         nr2: [String]? = nil,
         nr3: [String]? = nil,
         nr4: [String]? = nil,
         nr5: [String]? = nil) async {
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
                let params = Params().params(config: testconfigurations[i])
                let rsyncparameterssynchronize = RsyncParametersSynchronize(parameters: params)

                switch testconfigurations[i].task {
                case TestSharedReference.shared.synchronize:
                    do {
                        try rsyncparameterssynchronize.argumentsForSynchronize(forDisplay: false, verify: false, dryrun: true)
                    } catch {}
                case TestSharedReference.shared.snapshot:
                    do {
                        try rsyncparameterssynchronize.argumentsForSynchronizeSnapshot(forDisplay: false, verify: false, dryrun: true)
                    } catch {}
                case TestSharedReference.shared.syncremote:
                    do {
                        try rsyncparameterssynchronize.argumentsForSynchronizeRemote(forDisplay: false, verify: false, dryrun: true)
                    } catch {}
                default:
                    break
                }

                switch i {
                case 0:
                    nr0 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronize().nr0 == nr0)
                case 1:
                    nr1 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronize().nr1 == nr1)
                case 2:
                    nr2 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronize().nr2 == nr2)
                case 3:
                    nr3 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronize().nr3 == nr3)
                case 4:
                    nr4 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronize().nr4 == nr4)
                case 5:
                    nr5 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronize().nr5 == nr5)
                default:
                    return
                }
            }
        }
    }

    @Test func LodaDataTestRestore() async {
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let params = Params().params(config: testconfigurations[i])
                let rsyncparametersrestore = RsyncParametersRestore(parameters: params)

                switch testconfigurations[i].task {
                case TestSharedReference.shared.synchronize:
                    do {
                        try rsyncparametersrestore.remoteArgumentsFileList()
                    } catch {}

                case TestSharedReference.shared.snapshot:
                    do {
                        try rsyncparametersrestore.remoteArgumentsSnapshotFileList()
                    } catch {}

                default:
                    break
                }

                switch i {
                case 0:
                    nr0 = rsyncparametersrestore.computedArguments
                    #expect(ArgumentsRestoreFilelist().nr0 == nr0)
                case 1:
                    nr1 = rsyncparametersrestore.computedArguments
                    #expect(ArgumentsRestoreFilelist().nr1 == nr1)
                case 2:
                    nr2 = rsyncparametersrestore.computedArguments
                    #expect(ArgumentsRestoreFilelist().nr2 == nr2)
                case 3:
                    nr3 = rsyncparametersrestore.computedArguments
                    #expect(ArgumentsRestoreFilelist().nr3 == nr3)
                case 4:
                    let arguments = rsyncparametersrestore.computedArguments
                    #expect(arguments.isEmpty == true)
                case 5:
                    let arguments = rsyncparametersrestore.computedArguments
                    #expect(arguments.isEmpty == true)
                default:
                    return
                }
            }
        }
    }

    @Test func LodaDataTestRestoreFiles() async {
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let params = Params().params(config: testconfigurations[i])
                let rsyncparametersrestore = RsyncParametersRestore(parameters: params)

                do {
                    try rsyncparametersrestore.argumentsRestore(forDisplay: false, verify: false, dryrun: true, restoreSnapshotByFiles: false)
                } catch {}
                switch i {
                case 0:
                    nr0 = rsyncparametersrestore.computedArguments
                    #expect(ArgumentsRestore().nr0 == nr0)
                case 1:
                    nr1 = rsyncparametersrestore.computedArguments
                    #expect(ArgumentsRestore().nr1 == nr1)
                case 2:
                    nr2 = rsyncparametersrestore.computedArguments
                    #expect(ArgumentsRestore().nr2 == nr2)
                case 3:
                    nr3 = rsyncparametersrestore.computedArguments
                    #expect(ArgumentsRestore().nr3 == nr3)
                case 4:
                    let arguments = rsyncparametersrestore.computedArguments
                    #expect(arguments.isEmpty == true)
                case 5:
                    let arguments = rsyncparametersrestore.computedArguments
                    #expect(arguments.isEmpty == true)
                default:
                    return
                }
            }
        }
    }

    @Test func LodaDataSSHCommands() async {
        if let testconfigurations {
            // It are six test configurations
            for i in 0 ..< testconfigurations.count {
                let sshparameters = Params().sshparams(config: testconfigurations[i])
                let sshcommands = SnapshotDelete(sshParameters: sshparameters)

                switch i {
                case 0:
                    let nr0 = sshcommands.snapshotDelete(remoteCatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr0 == nr0)
                case 1:
                    let nr1 = sshcommands.snapshotDelete(remoteCatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr1 == nr1)
                case 2:
                    let nr2 = sshcommands.snapshotDelete(remoteCatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr2 == nr2)
                case 3:
                    let nr3 = sshcommands.snapshotDelete(remoteCatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr3 == nr3)
                case 4:
                    let nr4 = sshcommands.snapshotDelete(remoteCatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr4 == nr4)
                case 5:
                    let nr5 = sshcommands.snapshotDelete(remoteCatalog: "Remote")
                    #expect(ArgumentsDeleteSnapshot().nr5 == nr5)
                default:
                    return
                }
            }
        }
    }
}

@MainActor
@Suite final class TestSynchronizeNOSSH {
    var testconfigurations: [TestSynchronizeConfiguration]?
    // Save computed parameters
    var nr0: [String]?
    var nr1: [String]?
    var nr2: [String]?
    var nr3: [String]?
    var nr4: [String]?
    var nr5: [String]?

    init(testconfigurations: [TestSynchronizeConfiguration]? = nil,
         nr0: [String]? = nil,
         nr1: [String]? = nil,
         nr2: [String]? = nil,
         nr3: [String]? = nil,
         nr4: [String]? = nil,
         nr5: [String]? = nil) async {
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
                let params = Params().params(config: testconfigurations[i])
                let rsyncparameterssynchronize = RsyncParametersSynchronize(parameters: params)

                switch testconfigurations[i].task {
                case TestSharedReference.shared.synchronize:
                    do {
                        try rsyncparameterssynchronize.argumentsForSynchronize(forDisplay: false, verify: false, dryrun: true)
                    } catch {}
                case TestSharedReference.shared.snapshot:
                    do {
                        try rsyncparameterssynchronize.argumentsForSynchronizeSnapshot(forDisplay: false, verify: false, dryrun: true)

                    } catch {}
                case TestSharedReference.shared.syncremote:
                    do {
                        try rsyncparameterssynchronize.argumentsForSynchronizeRemote(forDisplay: false, verify: false, dryrun: true)

                    } catch {}
                default:
                    break
                }

                switch i {
                case 0:
                    nr0 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronizeNOSSH().nr0 == nr0)
                case 1:
                    nr1 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronizeNOSSH().nr1 == nr1)
                case 2:
                    nr2 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronizeNOSSH().nr2 == nr2)
                case 3:
                    nr3 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronizeNOSSH().nr3 == nr3)
                case 4:
                    nr4 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronizeNOSSH().nr4 == nr4)
                case 5:
                    nr5 = rsyncparameterssynchronize.computedArguments
                    #expect(ArgumentsSynchronizeNOSSH().nr5 == nr5)
                default:
                    return
                }
            }
        }
    }
}

@MainActor
@Suite final class TestPullPush {
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
        self.testconfigurations = loadtestdata.testconfigurations.compactMap { configuration in
            (configuration.task == "synchronize" && configuration.offsiteServer.isEmpty == false) ? configuration : nil
        }
    }

    @Test func TestPull() async {
        if let testconfigurations {
            // It are THREE test configurations for pull and push
            for i in 0 ..< testconfigurations.count {
                let params = Params().params(config: testconfigurations[i])
                let rsyncparameterspull = RsyncParametersPullRemote(parameters: params)

                do {
                    try rsyncparameterspull.argumentsPullRemoteWithParameters(forDisplay: false, verify: false, dryrun: true, keepDelete: false)
                } catch {}

                switch i {
                case 0:
                    nr0 = rsyncparameterspull.computedArguments
                    #expect(ArgumentsPull().nr0 == nr0)
                case 1:
                    nr1 = rsyncparameterspull.computedArguments
                    #expect(ArgumentsPull().nr1 == nr1)
                case 2:
                    nr2 = rsyncparameterspull.computedArguments
                    #expect(ArgumentsPull().nr2 == nr2)
                default:
                    return
                }
            }
        }
    }

    @Test func TestPush() async {
        if let testconfigurations {
            // It are THREE test configurations for pull and push
            for i in 0 ..< testconfigurations.count {
                let params = Params().params(config: testconfigurations[i])
                let rsyncparameterpush = RsyncParametersSynchronize(parameters: params)

                do {
                    try rsyncparameterpush.argumentsForPushLocalToRemoteWithParameters(forDisplay: false, verify: false, dryrun: true, keepDelete: false)

                } catch {}

                switch i {
                case 0:
                    nr0 = rsyncparameterpush.computedArguments
                    #expect(ArgumentsPush().nr0 == nr0)
                case 1:
                    nr1 = rsyncparameterpush.computedArguments
                    #expect(ArgumentsPush().nr1 == nr1)
                case 2:
                    nr2 = rsyncparameterpush.computedArguments
                    #expect(ArgumentsPush().nr2 == nr2)
                default:
                    return
                }
            }
        }
    }
}
