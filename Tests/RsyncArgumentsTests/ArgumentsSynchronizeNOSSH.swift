//
//  File.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 13/09/2024.
//

import Foundation

struct ArgumentsSynchronizeNOSSH {
    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --compress --delete --exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt --dry-run --stats --link-dest=/backups/snapshots_JSON/53 /Users/thomas/GitHub/ thomas@raspberrypi:/backups/snapshots_JSON/54

    let nr0 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "--link-dest=/backups/snapshots_JSON/53",
               "/Users/thomas/GitHub/",
               "thomas@raspberrypi:/backups/snapshots_JSON/54"]

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --compress --delete --include-from=/Users/thomas/Documents/includersync/include-list-github.txt --max-size=14K --exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt --dry-run --stats /Users/thomas/Pictures_raw/ thomas@raspberrypi:/backups/Pictures_dopfiles/

    let nr1 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "--include-from=/Users/thomas/Documents/includersync/include-list-github.txt",
               "--max-size=14K",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "/Users/thomas/Pictures_raw/",
               "thomas@raspberrypi:/backups/Pictures_dopfiles/"]

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // opt/homebrew/bin/rsync --archive --verbose --compress --delete --backup --backup-dir=../backup_Documents --dry-run --stats /Users/thomas/Documents/ thomas@raspberrypi:/backups/Documents/

    let nr2 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "--backup",
               "--backup-dir=../backup_Documents",
               "--dry-run",
               "--stats",
               "/Users/thomas/Documents/",
               "thomas@raspberrypi:/backups/Documents/"]

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --compress --delete -e  "ssh -i ~/.ssh_local/local -p 3333"  --exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt --dry-run --stats /Users/thomas/GitHub/ thomas@raspberrypi:/backups/GitHub/

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

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --delete --dry-run --stats /Users/thomas/Documents/ /Volumes/WesternDigitalBackup/backup/Documents/

    let nr4 = ["--archive",
               "--verbose",
               "--delete",
               "--dry-run",
               "--stats",
               "/Users/thomas/Documents/",
               "/Volumes/WesternDigitalBackup/backup/Documents/"]

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --compress --delete --dry-run --stats thomas@raspberrypi:/home/thomas/Downloads/ /Users/thomas/Downloads/

    let nr5 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "--dry-run",
               "--stats",
               "thomas@raspberrypi:/home/thomas/Downloads/",
               "/Users/thomas/Downloads/"]
}

