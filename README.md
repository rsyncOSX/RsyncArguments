## Hi there 👋

This package is under development.

This package is code for creating parameters to `rsync` in RsyncUI. The package is used in [Version 2.1.0 and later](https://github.com/rsyncOSX/RsyncUI). To be released as part of RsyncUI in September or October 2024.

In RsyncUI there are three rsync commands: 

- `synchronize`, which is default and keeps source and destination in sync
- `snapshot`, save changes and deletes ahead of a synchronize
- `syncremote`, remote is source, synchronize a remote source to a local volume

By Using Swift Package Manager (SPM), parts of the source code in RsyncUI is extraced and created as packages. The old code, the base for packages, is deleted and RsyncUI imports the new packages. 

In Xcode 16 there is also a new module, Swift Testing, for testing packages. By creating packages and Swift Testing, important code is isolated and tested to verify it is working as expected. By SPM and Swift Testing, the code for RsyncUI is modularized, isolated, and tested before committing changes.

