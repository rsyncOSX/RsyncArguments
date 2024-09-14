//
//  ArgumentsSynchronize.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 06/08/2024.
//

import Foundation

struct ArgumentsSynchronize {
   
    let nr0 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "-e",
               "ssh -i ~/.ssh_local/local",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "--link-dest=/backups/snapshots_JSON/53",
               "/Users/thomas/GitHub/",
               "thomas@raspberrypi:/backups/snapshots_JSON/54"]
    
    let nr1 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "-e",
               "ssh -p 3333",
               "--include-from=/Users/thomas/Documents/includersync/include-list-github.txt",
               "--max-size=14K",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "/Users/thomas/Pictures_raw/",
               "thomas@raspberrypi:/backups/Pictures_dopfiles/"]

    let nr2 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "--backup",
               "--backup-dir=../backup_Documents",
               "--dry-run",
               "--stats",
               "/Users/thomas/Documents/",
               "thomas@raspberrypi:/backups/Documents/"]

    let nr3 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "-e",
               "ssh -i ~/.ssh_local/local -p 3333",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "/Users/thomas/GitHub/",
               "thomas@raspberrypi:/backups/GitHub/"]

    let nr4 = ["--archive",
               "--verbose",
               "--delete",
               "--dry-run",
               "--stats",
               "/Users/thomas/Documents/",
               "/Volumes/WesternDigitalBackup/backup/Documents/"]

    let nr5 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "--dry-run",
               "--stats",
               "thomas@raspberrypi:/home/thomas/Downloads/",
               "/Users/thomas/Downloads/"]
}
