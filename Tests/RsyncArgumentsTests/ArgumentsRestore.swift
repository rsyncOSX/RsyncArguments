//
//  ArgumentsRestore.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 09/08/2024.
//

import Foundation

struct ArgumentsRestore {
    let nr0 = ["--archive",
               "--verbose",
               "--compress",
               "--dry-run",
               "--stats",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/snapshots_JSON/53/",
               "/Users/thomas/tmp"]

    let nr1 = ["--archive",
               "--verbose",
               "--compress",
               "--dry-run",
               "--stats",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/Pictures_dopfiles/",
               "/Users/thomas/tmp"]

    let nr2 = ["--archive",
               "--verbose",
               "--compress",
               "--dry-run",
               "--stats",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "thomas@raspberrypi:/backups/Documents/",
               "/Users/thomas/tmp"]

    let nr3 = ["--archive",
               "--verbose",
               "--compress",
               "--dry-run",
               "--stats",
               "-e",
               "ssh -i ~/.ssh_local/local -p 3333",
               "thomas@raspberrypi:/backups/GitHub/",
               "/Users/thomas/tmp"]

    let nr4 = [""]
    let nr5 = [""]
}
