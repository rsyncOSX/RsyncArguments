//
//  ArgumentsRestoreFilelist.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 07/08/2024.
//

import Foundation

struct ArgumentsRestoreFilelist {
    // Arguments for listing files in view for Restore file.
    // Before executing a restore task, list of files to restore are presented.

    // IMPORTANT rsync version: to support both versions of rsync, the
    // ssh parameters must be last.

    // List catalogs only in root of snapshots Restore View.
    // List snapshotcatalogs Snapshot View.

    let nr0 = ["--verbose",
               "--compress",
               "--list-only",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/snapshots_JSON/"]

    // The rest are various tasks, list files.

    let nr1 = ["--verbose",
               "--compress",
               "-r",
               "--list-only",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/Pictures_dopfiles/"]

    let nr2 = ["--verbose",
               "--compress",
               "-r",
               "--list-only",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/Documents/"]

    let nr3 = ["--verbose",
               "--compress",
               "-r",
               "--list-only",
               "-e",
               "ssh -i ~/.ssh_local/local -p 3333",
               "thomas@raspberrypi:/backups/GitHub/"]
}
