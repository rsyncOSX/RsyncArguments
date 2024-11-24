//
//  ArgumentsPullPush.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 24/11/2024.
//

struct ArgumentsPullPush {
    let nr0 = ["--archive",
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
}
