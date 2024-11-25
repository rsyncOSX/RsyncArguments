//
//  ArgumentsPush.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 24/11/2024.
//

struct ArgumentsPush {
    
    let nr0 = ["--archive",
               "--verbose",
               "--compress",
               "-e",
               "ssh -p 3333",
               "--include-from=/Users/thomas/Documents/includersync/include-list-github.txt",
               "--max-size=14K",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "--update",
               "--exclude=.git/",
               "--exclude=.DS_Store",
               "/Users/thomas/Pictures_raw/",
               "thomas@raspberrypi:/backups/Pictures_dopfiles/"]
    
    let nr1 = ["--archive",
               "--verbose",
               "--compress",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "--backup",
               "--backup-dir=../backup_Documents",
               "--dry-run",
               "--stats",
               "--update",
               "--exclude=.git/",
               "--exclude=.DS_Store",
               "/Users/thomas/Documents/",
               "thomas@raspberrypi:/backups/Documents/"]
    
    let nr2 = ["--archive",
               "--verbose",
               "--compress",
               "-e",
               "ssh -i ~/.ssh_local/local -p 3333",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "--update",
               "--exclude=.git/",
               "--exclude=.DS_Store",
               "/Users/thomas/GitHub/",
               "thomas@raspberrypi:/backups/GitHub/"]
}
