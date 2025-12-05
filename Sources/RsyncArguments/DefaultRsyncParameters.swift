//  DefaultRsyncParameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 02/08/2024.
//
//
//  DefaultRsyncParameters.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 02/08/2024.
//

import Foundation

/// Standard rsync parameters and task types
public enum DefaultRsyncParameters: String, CaseIterable, Identifiable, CustomStringConvertible {
    // Rsync flags
    case verifyChecksum = "--checksum"
    case archiveMode = "--archive"
    case verboseOutput = "--verbose"
    case compressionEnabled = "--compress"
    case deleteExtraneous = "--delete"
    case recursiveMode = "--recursive"
    case statisticsOutput = "--stats"
    case dryRunMode = "--dry-run"
    case linkDestination = "--link-dest="

    // Task types
    case synchronize
    case snapshot
    case syncremote

    public var id: String { rawValue }
    public var description: String { rawValue.localizedLowercase }
}
