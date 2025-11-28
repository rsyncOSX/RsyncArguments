# RsyncArguments

A Swift package for building rsync command arguments in RsyncUI. This package provides type-safe, maintainable builders for creating rsync parameters for synchronization, snapshot, and remote sync operations.

## Features

- ✅ **Type-safe** parameter configuration
- ✅ **Immutable** argument building (no side effects)
- ✅ **Clear naming** - descriptive property names instead of `parameter1-14`
- ✅ **Error handling** with proper Swift error types
- ✅ **Modular design** - separated concerns for SSH, core params, and optional params
- ✅ **Comprehensive** support for synchronize, snapshot, and syncremote tasks

## Usage

### Basic Synchronization

```swift
import RsyncArguments

// Create parameter configuration
let basicParams = BasicRsyncParameters(
    archiveMode: "--archive",
    verboseOutput: "--verbose",
    compressionEnabled: "--compress",
    deleteExtraneous: "--delete"
)

let sshParams = SSHParameters(
    offsiteServer: "backup.example.com",
    offsiteUsername: "user",
    sshport: "22",
    sshkeypathandidentityfile: "~/.ssh/id_rsa",
    sharedsshport: nil,
    sharedsshkeypathandidentityfile: nil,
    rsyncversion3: true
)

let paths = PathConfiguration(
    localCatalog: "/Users/user/Documents/",
    offsiteCatalog: "/backup/documents/"
)

let params = Parameters(
    task: DefaultRsyncParameters.synchronize.rawValue,
    basicParameters: basicParams,
    optionalParameters: OptionalRsyncParameters(),
    sshParameters: sshParams,
    paths: paths,
    snapshotNumber: nil,
    isRsyncDaemon: false,
    rsyncVersion3: true
)

// Build arguments
let builder = RsyncParametersSynchronize(parameters: params)
try builder.argumentsForSynchronize(forDisplay: false, verify: false, dryrun: false)

print(builder.computedArguments)
// Output: ["--archive", "--verbose", "--compress", "--delete", "-e", "ssh -i ~/.ssh/id_rsa -p 22", ...]
```

### Snapshot Synchronization

```swift
let params = Parameters(
    task: DefaultRsyncParameters.snapshot.rawValue,
    basicParameters: basicParams,
    optionalParameters: OptionalRsyncParameters(),
    sshParameters: sshParams,
    paths: paths,
    snapshotNumber: 5,  // Snapshot number
    isRsyncDaemon: false,
    rsyncVersion3: true
)

let builder = RsyncParametersSynchronize(parameters: params)
try builder.argumentsForSynchronizeSnapshot(forDisplay: false, verify: false, dryrun: false)
```

### Pull from Remote

```swift
let pullBuilder = RsyncParametersPullRemote(parameters: params)
try pullBuilder.argumentsPullRemote(forDisplay: false, verify: false, dryrun: false)
```

### Restore Files

```swift
let restoreParams = Parameters(
    task: DefaultRsyncParameters.synchronize.rawValue,
    basicParameters: basicParams,
    optionalParameters: OptionalRsyncParameters(),
    sshParameters: sshParams,
    paths: PathConfiguration(
        localCatalog: "/Users/user/Documents/",
        offsiteCatalog: "/backup/documents/",
        sharedPathForRestore: "/Users/user/Restore/"
    ),
    snapshotNumber: nil,
    isRsyncDaemon: false,
    rsyncVersion3: true
)

let restoreBuilder = RsyncParametersRestore(parameters: restoreParams)
try restoreBuilder.argumentsRestore(
    forDisplay: false,
    verify: false,
    dryrun: true,
    restoreSnapshotByFiles: false
)
```

### SSH Commands

```swift
// Create snapshot root catalog
let sshParams = SSHParameters(
    server: "backup.example.com",
    username: "user",
    localConfig: SSHConfiguration(port: 22, identityFile: "~/.ssh/id_rsa"),
    sharedConfig: SSHConfiguration(port: nil, identityFile: nil),
    rsyncVersion3: true
)

let createCatalog = SnapshotCreateRootCatalog(sshParameters: sshParams)
let args = createCatalog.snapshotCreateRootCatalog(offsiteCatalog: "/backup/snapshots/")

// Delete snapshot
let deleteSnapshot = SnapshotDelete(sshParameters: sshParams)
let deleteArgs = deleteSnapshot.snapshotDelete(remoteCatalog: "/backup/snapshots/5/")

// Check remote size
let remoteSize = RemoteSize(sshParameters: sshParams)
if let sizeArgs = remoteSize.remoteDiskSize(remoteCatalog: "/backup/") {
    // Use sizeArgs to execute command
}
```

## Architecture

### Core Components

- **Parameters** - Main configuration container with structured parameter groups
- **RsyncParametersSynchronize** - Builds arguments for sync, snapshot, and syncremote
- **RsyncParametersRestore** - Builds arguments for restore operations
- **RsyncParametersPullRemote** - Builds arguments for pulling from remote
- **SSHParameterBuilder** - Consolidated SSH parameter building
- **RsyncArgumentBuilder** - Helper for building argument arrays

### Configuration Structures

- **BasicRsyncParameters** - Core rsync flags (archive, verbose, compress, delete)
- **OptionalRsyncParameters** - User-defined parameters 8-14
- **SSHConfiguration** - SSH port and identity file settings
- **SSHParameters** - Complete SSH configuration with server info
- **PathConfiguration** - Source and destination paths

## Error Handling

All public methods that can fail throw `ParameterError`:

```swift
public enum ParameterError: LocalizedError {
    case missingLocalCatalog
    case missingOffsiteCatalog
    case missingOffsiteServer
    case missingOffsiteUsername
    case invalidTaskType
    case invalidSnapshotNumber
    case invalidSSHConfiguration
}
```

Example error handling:

```swift
do {
    try builder.argumentsForSynchronize(forDisplay: false, verify: false, dryrun: false)
} catch ParameterError.missingOffsiteServer {
    print("Server configuration required for remote sync")
} catch {
    print("Error: \(error.localizedDescription)")
}
```

### Parameters

```swift
let params = Parameters(
    task: DefaultRsyncParameters.synchronize.rawValue,
    basicParameters: BasicRsyncParameters(
        archiveMode: "--archive",
        verboseOutput: "--verbose",
        compressionEnabled: "--compress",
        deleteExtraneous: "--delete"
    ),
    optionalParameters: OptionalRsyncParameters(),
    sshParameters: sshParams,
    paths: pathConfig,
    snapshotNumber: nil,
    isRsyncDaemon: false,
    rsyncVersion3: true
)
```

## Requirements

- Swift 5.9+
- macOS 13.0+ / iOS 16.0+

## License

MIT

## Author

Thomas Evensen