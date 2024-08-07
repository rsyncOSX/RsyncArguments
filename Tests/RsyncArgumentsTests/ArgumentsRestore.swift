//
//  ArgumentsRestore.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 07/08/2024.
//

import Foundation

struct ArgumentsRestore {
    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --compress --delete -e  "ssh -i ~/.ssh_rsyncosx/rsyncosx -p 22"  --exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt --dry-run --stats  thomas@raspberrypi:/backups/snapshots_JSON/53/ /Users/thomas/GitHub/

    let nr0 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "thomas@raspberrypi:/backups/snapshots_JSON/53",
               "/Users/thomas/GitHub/"]

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --compress --delete -e  "ssh -i ~/.ssh_rsyncosx/rsyncosx -p 22"  --include-from=/Users/thomas/Documents/includersync/include-list-github.txt --max-size=14K --exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt --dry-run --stats  thomas@raspberrypi:/backups/Pictures_dopfiles/ /Users/thomas/Pictures_raw/

    let nr1 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "-e",
               "ssh -i ~/.ssh_global/global -p 2222",
               "--include-from=/Users/thomas/Documents/includersync/include-list-github.txt",
               "--max-size=14K",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "thomas@raspberrypi:/backups/Pictures_dopfiles/",
               "/Users/thomas/Pictures_raw/"]

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --compress --delete -e  "ssh -i ~/.ssh_rsyncosx/rsyncosx -p 22"  --backup --backup-dir=../backup_Documents --dry-run --stats  thomas@raspberrypi:/backups/Documents/ /Users/thomas/Documents/

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
               "thomas@raspberrypi:/backups/Documents/",
               "/Users/thomas/Documents/"]

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --compress --delete -e  "ssh -i ~/.ssh_local/local -p 3333"  --exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt --dry-run --stats  thomas@raspberrypi:/backups/GitHub/ /Users/thomas/GitHub/

    let nr3 = ["--archive",
               "--verbose",
               "--compress",
               "--delete",
               "-e",
               "ssh -i ~/.ssh_local/local -p 3333",
               "--exclude-from=/Users/thomas/Documents/excludersync/exclude-list-github.txt",
               "--dry-run",
               "--stats",
               "thomas@raspberrypi:/backups/GitHub/",
               "/Users/thomas/GitHub/"]

    // The full rsync command is, macOS Silicon with rsync from Homebrew:
    // /opt/homebrew/bin/rsync --archive --verbose --delete --dry-run --stats /Volumes/WesternDigitalBackup/backup/Documents/ /Users/thomas/Documents/

    let nr4 = ["--archive",
               "--verbose",
               "--delete",
               "--dry-run",
               "--stats",
               "/Volumes/WesternDigitalBackup/backup/Documents/",
               "/Users/thomas/Documents/"]

    // Arguments for collecting file list
}
