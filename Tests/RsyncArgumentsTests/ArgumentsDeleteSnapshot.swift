//
//  ArgumentsDeleteSnapshot.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 12/08/2024.
//

import Foundation

struct ArgumentsDeleteSnapshot {
    let nr0 = ["-i", "~/.ssh_global/global","-p","2222","thomas@raspberrypi","rm -rf Remote"]
    let nr1 = ["-i","~/.ssh_global/global -p 2222", "thomas@raspberrypi", "rm -rf Remote"]
    let nr2 = ["-i","~/.ssh_global/global","-p","2222", "thomas@raspberrypi", "rm -rf Remote"]
    let nr3 = ["-i","~/.ssh_local/local","-p","3333","thomas@raspberrypi","rm -rf Remote"]
    let nr4 = ["-rf","Remote"]
    let nr5 = ["-i","~/.ssh_global/global","-p","2222","thomas@raspberrypi","rm -rf Remote"]
}
