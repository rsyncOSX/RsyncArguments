//
//  SSHParametersRsync.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 08/08/2024.
//

import Foundation

public enum Verifysshparameters: String, CaseIterable, Identifiable, CustomStringConvertible {
    case localesshport
    case localesshkeypath
    case alllocale
    case allglobal
    case essh // set -e ssh

    public var id: String { rawValue }
    public var description: String { rawValue.localizedLowercase }
}

public class SSHParametersRsync {
    // -e "ssh -i ~/.ssh/id_myserver -p 22"
    // -e "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
    // default is
    // -e "ssh -i ~/.ssh/id_rsa -p 22"

    var computedarguments = [String]()
    var offsiteServer = ""
    var sshport: String?
    var sshkeypathandidentityfile: String?
    var sharedsshport: String?
    var sharedsshkeypathandidentityfile: String?

    var rsyncversion3 = false
    
    // Only set -e ssh
    public func setessh(forDisplay: Bool) {
        if forDisplay { computedarguments.append(" ") }
        computedarguments.append("-e ssh")
        if forDisplay { computedarguments.append(" ") }
    }

    // Local params rules global settings
    public func sshparameterslocal(forDisplay: Bool) {
        computedarguments.append("-e")
        if forDisplay { computedarguments.append(" ") }
        if let sshkeypathandidentityfile, sshkeypathandidentityfile.isEmpty == false {
            if forDisplay { computedarguments.append(" \"") }
            // Then check if ssh port is set also
            if let sshport, sshport != "-1" {
                // "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
                computedarguments.append("ssh -i " + sshkeypathandidentityfile + " " + "-p " + String(sshport))
            } else {
                computedarguments.append("ssh -i " + sshkeypathandidentityfile)
            }
            if forDisplay { computedarguments.append("\" ") }
        } else if let sshport, sshport != "-1" {
            // "ssh -p xxx"
            if forDisplay { computedarguments.append(" \"") }
            computedarguments.append("ssh -p " + String(sshport))
            if forDisplay { computedarguments.append("\" ") }
        }
        if forDisplay { computedarguments.append(" ") }
    }

    // Global ssh parameters
    public func sshparametersglobal(forDisplay: Bool) {
        computedarguments.append("-e")
        if forDisplay { computedarguments.append(" ") }
        if let sshkeypathandidentityfile = sharedsshkeypathandidentityfile,
           sshkeypathandidentityfile.isEmpty == false
        {
            if forDisplay { computedarguments.append(" \"") }
            // Then check if ssh port is set also
            if let sshport = sharedsshport, sshport != "-1" {
                // "ssh -i ~/sshkeypath/sshidentityfile -p portnumber"
                computedarguments.append("ssh -i " + sshkeypathandidentityfile + " " + "-p " + String(sshport))
            } else {
                computedarguments.append("ssh -i " + sshkeypathandidentityfile)
            }
            if forDisplay { computedarguments.append("\" ") }
        } else if let sshport = sharedsshport, sshport != "-1" {
            // "ssh -p xxx"
            if forDisplay { computedarguments.append(" \"") }
            computedarguments.append("ssh -p " + String(sshport))
            if forDisplay { computedarguments.append("\" ") }
        }
        if forDisplay { computedarguments.append(" ") }
    }
    
    public func verifysshparameters() -> Verifysshparameters? {
        if let sshport, sshport != "-1",
           let sshkeypathandidentityfile, sshkeypathandidentityfile.isEmpty == true
        {
            return .localesshport
        } else if let sshkeypathandidentityfile, sshkeypathandidentityfile.isEmpty == false,
                  let sshport, sshport == "-1"
        {
            return .localesshkeypath
        } else if let sshport, sshport != "-1",
                  let sshkeypathandidentityfile, sshkeypathandidentityfile.isEmpty == false
        {
            return .alllocale
        } else if let sharedsshkeypathandidentityfile, sharedsshkeypathandidentityfile.isEmpty == false,
                  let sharedsshport, sharedsshport != "-1"
        {
            return .allglobal
        } else if let sharedsshkeypathandidentityfile, sharedsshkeypathandidentityfile.isEmpty == false {
            return .allglobal
        } else if let sharedsshport, sharedsshport != "-1" {
            return .allglobal
        } else if sshport == "-1",
                  let sshkeypathandidentityfile, sshkeypathandidentityfile.isEmpty == true ,
                  let sharedsshport, sharedsshport == "-1",
                    sharedsshkeypathandidentityfile == nil {
            return .essh
        }  else if sshport == "-1",
                   sshkeypathandidentityfile == nil ,
                   let sharedsshport, sharedsshport == "-1",
                   sharedsshkeypathandidentityfile == nil {
            return .essh
        } else if sshport == "-1",
                  sshkeypathandidentityfile == nil ,
                  let sharedsshport, sharedsshport == "-1",
                  let sharedsshkeypathandidentityfile, sharedsshkeypathandidentityfile.isEmpty == true {
            return .essh
        }
        return nil
    }

    public init(offsiteServer: String,
                sshport: String?,
                sshkeypathandidentityfile: String?,
                sharedsshport: String?,
                sharedsshkeypathandidentityfile: String?,
                rsyncversion3: Bool)
    {
        self.offsiteServer = offsiteServer
        self.sshport = sshport
        self.sshkeypathandidentityfile = sshkeypathandidentityfile
        self.sharedsshport = sharedsshport
        self.sharedsshkeypathandidentityfile = sharedsshkeypathandidentityfile
        self.rsyncversion3 = rsyncversion3

        computedarguments.removeAll()
    }
}
