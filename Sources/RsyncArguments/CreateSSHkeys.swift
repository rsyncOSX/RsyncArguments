//
//  CreateSSHkeys.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 13/08/2024.
//

import Foundation

@MainActor
public final class CreateSSHkeys {
        
    var offsiteServer = ""
    var offsiteUsername = ""
    var sshport: String?
    var sshkeypathandidentityfile: String?
    var sharedsshport: String?
    var sharedsshkeypathandidentityfile: String?
    
    // Set parameters for ssh-copy-id for copy public ssh key to server
    // ssh-address = "backup@server.com"
    // ssh-copy-id -i $ssh-keypath -p port $ssh-address
    public func argumentssshcopyid() -> String? {
        guard offsiteServer.isEmpty == false else { return nil }
        var args = [String]()
        let command = "/usr/bin/ssh-copy-id"
        args.append(command)
        args.append("-i")
        if let sharedsshkeypathandidentityfile,
           let sharedsshport,
            sharedsshkeypathandidentityfile.isEmpty == false,
            sharedsshport != "-1" {
            args.append(sharedsshkeypathandidentityfile)
            args.append("-p")
            args.append(sharedsshport)
        }
        args.append(remotearges())
        return args.joined(separator: " ")
    }


    // Check if pub key exists on remote server
    // ssh -p port -i $ssh-keypath $ssh-address
    public func argumentscheckremotepubkey() -> String? {
        guard offsiteServer.isEmpty == false else { return nil }
        var args = [String]()
        let command = "/usr/bin/ssh"
        args.append(command)
        if let sharedsshport, sharedsshport != "-1" {
            args.append("-p")
            args.append(sharedsshport)
        }
        args.append("-i")
        if let sharedsshkeypathandidentityfile,
           sharedsshkeypathandidentityfile.isEmpty == false {
            args.append(sharedsshkeypathandidentityfile)
        }
        
        args.append(remotearges())
        return args.joined(separator: " ")
    }

    // Create local key with ssh-keygen
    // Generate a passwordless RSA keyfile -N sets password, "" makes it blank
    // ssh-keygen -t rsa -N "" -f $ssh-keypath
    public func argumentscreatekey() -> [String]? {
        var args = [String]()
        let command = "/usr/bin/ssh-keygen"
        args.append(command)
        args.append("-t")
        args.append("rsa")
        args.append("-N")
        args.append("")
        args.append("-f")
        if let sharedsshkeypathandidentityfile,
           sharedsshkeypathandidentityfile.isEmpty == false {
            args.append(sharedsshkeypathandidentityfile)
        }
        return args
    }

    private func remotearges() -> String {
        offsiteUsername + "@" + offsiteServer
    }


    public init(offsiteServer: String,
                offsiteUsername: String,
                sshport: String?,
                sshkeypathandidentityfile: String?,
                sharedsshport: String?,
                sharedsshkeypathandidentityfile: String?) {
        self.offsiteServer = offsiteServer
        self.offsiteUsername = offsiteUsername
        self.sshport = sshport
        self.sshkeypathandidentityfile = sshkeypathandidentityfile
        self.sharedsshport = sharedsshport
        self.sharedsshkeypathandidentityfile = sharedsshkeypathandidentityfile
    }
}
