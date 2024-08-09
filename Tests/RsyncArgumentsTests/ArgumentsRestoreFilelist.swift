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

    let nr0 = ["--verbose",
               "--compress",
               // "--stats",
               "--list-only",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/snapshots_JSON/"]

    let nr1 = ["--verbose",
               "--compress",
               // "--stats",
               "-r",
               "--list-only",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/Pictures_dopfiles/"]

    let nr2 = ["--verbose",
               "--compress",
               // "--stats",
               "-r",
               "--list-only",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/Documents/"]


    let nr3 = ["--verbose",
               "--compress",
               // "--stats",
               "-r",
               "--list-only",
               "-e",
               "ssh -i ~/.ssh_local/local -p 3333",
               "thomas@raspberrypi:/backups/GitHub/"]
}
