//
//  CreateSSHkeys.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 13/08/2024.
//

import Foundation

@MainActor
public final class CreateSSHkeys {
    
    // var offsiteServer = ""
    // var offsiteUsername = ""

    var sharedsshport: String?
    var sharedsshkeypathandidentityfile: String?
    
    public var rsaStringPath: String?
    // Arrays listing all key files
    public var keyFileStrings: [String]? {
        let fm = FileManager.default
        if let atpath = sshkeypathandidentityfile {
            var array = [String]()
            do {
                for files in try fm.contentsOfDirectory(atPath: atpath) {
                    array.append(files)
                }
                return array
            } catch {
                return nil
            }
        }
        return nil
    }

    // Path to ssh keypath
    public var sshkeypathandidentityfile: String? {
        if let sharedsshkeypathandidentityfile,
           let userHomeDirectoryPath
        {
            if sharedsshkeypathandidentityfile.first == "~" {
                // must drop identityfile and then set rootpath
                // also drop the "~" character
                let sshkeypathandidentityfilesplit = sharedsshkeypathandidentityfile.split(separator: "/")
                guard sshkeypathandidentityfilesplit.count > 2 else {
                    // If anything goes wrong set to default global values
                    return userHomeDirectoryPath + "/.ssh"
                }
                return userHomeDirectoryPath + sshkeypathandidentityfilesplit.joined(separator: "/").dropFirst()

            } else {
                // If anything goes wrong set to default global values
                return userHomeDirectoryPath + "/.ssh"
            }
        } else {
            return (userHomeDirectoryPath ?? "") + "/.ssh"
        }
    }

    // SSH identityfile with full keypath if NOT default is used
    // If default, only return defalt value
    public var identityfile: String? {
        if let sharedsshkeypathandidentityfile {
            if sharedsshkeypathandidentityfile.first == "~" {
                // must drop identityfile and then set rootpath
                // also drop the "~" character
                let sshkeypathandidentityfilesplit = sharedsshkeypathandidentityfile.split(separator: "/")
                guard sshkeypathandidentityfilesplit.count > 2 else {
                    // If anything goes wrong set to default global values
                    return "id_rsa"
                }
                return String(sshkeypathandidentityfilesplit[sshkeypathandidentityfilesplit.count - 1])
            } else {
                // If anything goes wrong set to default global values
                return "id_rsa"
            }
        } else {
            return "id_rsa"
        }
    }

    // Used when creating ssh keypath
    public var keypathonly: String? {
        if let sharedsshkeypathandidentityfile,
           let userHomeDirectoryPath
        {
            if sharedsshkeypathandidentityfile.first == "~" {
                // must drop identityfile and then set rootpath
                // also drop the "~" character
                let sshkeypathandidentityfilesplit = sharedsshkeypathandidentityfile.split(separator: "/")
                guard sshkeypathandidentityfilesplit.count > 2 else {
                    // If anything goes wrong set to default global values
                    return NSHomeDirectory()
                }
                return userHomeDirectoryPath +
                    sshkeypathandidentityfilesplit.joined(separator: "/").dropLast()

            } else {
                // If anything goes wrong set to default global values
                return userHomeDirectoryPath
            }
        } else {
            return userHomeDirectoryPath
        }
    }

    public var userHomeDirectoryPath: String? {
        let pw = getpwuid(getuid())
        if let home = pw?.pointee.pw_dir {
            let homePath = FileManager.default.string(withFileSystemRepresentation: home, length: Int(strlen(home)))
            return homePath
        } else {
            return nil
        }
    }

    // Create SSH catalog
    // If ssh catalog exists - bail out, no need to create
    public func createsshkeyrootpath() {
        let fm = FileManager.default
        if let keypathonly,
           let userHomeDirectoryPath
        {
            let sshkeypathString = userHomeDirectoryPath + "/." + keypathonly
            guard fm.keypathlocationExists(at: sshkeypathString, kind: .folder) == false else {
                return
            }

            let userHomeDirectoryPathURL = URL(fileURLWithPath: userHomeDirectoryPath)
            let sshkeypathlURL = userHomeDirectoryPathURL.appendingPathComponent("/." + keypathonly)

            do {
                try fm.createDirectory(at: sshkeypathlURL, withIntermediateDirectories: true, attributes: nil)
            } catch let e {
                let error = e
                // propogateerror(error: error)
                return
            }
        }
    }

    // Set parameters for ssh-copy-id for copy public ssh key to server
    // ssh-address = "backup@server.com"
    // ssh-copy-id -i $ssh-keypath -p port $ssh-address
    public func argumentssshcopyid(offsiteServer: String,
                                   offsiteUsername: String) -> String {
        var args = [String]()
        let command = "/usr/bin/ssh-copy-id"
        args.append(command)
        args.append("-i")
        if let sharedsshkeypathandidentityfile,
           let sharedsshport,
           sharedsshkeypathandidentityfile.isEmpty == false,
           sharedsshport != "-1"
        {
            args.append(sharedsshkeypathandidentityfile)
            args.append("-p")
            args.append(sharedsshport)
        }
        args.append( offsiteUsername + "@" + offsiteServer)
        return args.joined(separator: " ")
    }

    // Check if pub key exists on remote server
    // ssh -p port -i $ssh-keypath $ssh-address
    public func argumentscheckremotepubkey(offsiteServer: String,
                                           offsiteUsername: String) -> String {
        var args = [String]()
        let command = "/usr/bin/ssh"
        args.append(command)
        if let sharedsshport, sharedsshport != "-1" {
            args.append("-p")
            args.append(sharedsshport)
        }
        args.append("-i")
        if let sharedsshkeypathandidentityfile,
           sharedsshkeypathandidentityfile.isEmpty == false
        {
            args.append(sharedsshkeypathandidentityfile)
        }

        args.append( offsiteUsername + "@" + offsiteServer)
        return args.joined(separator: " ")
    }

    // Create local key with ssh-keygen
    // Generate a passwordless RSA keyfile -N sets password, "" makes it blank
    // ssh-keygen -t rsa -N "" -f $ssh-keypath
    public func argumentscreatekey() -> [String]? {
        var args = [String]()
        args.append("-t")
        args.append("rsa")
        args.append("-N")
        args.append("")
        args.append("-f")
        if let sharedsshkeypathandidentityfile,
           sharedsshkeypathandidentityfile.isEmpty == false
        {
            args.append(sharedsshkeypathandidentityfile)
        }
        return args
    }
    
    public func getfullkeypathonly() -> [String]? {
        let fm = FileManager.default
        if let atpath = keypathonly {
            var array = [String]()
            do {
                for files in try fm.contentsOfDirectory(atPath: atpath) {
                    array.append(files)
                }
                return array
            } catch {
                return nil
            }
        }
        return nil
    }
    
    // Check if rsa pub key exists
    public func islocalpublicrsakeypresent() throws -> Bool {
        guard keyFileStrings != nil else { return false }
        guard keyFileStrings?.filter({ $0.contains(sshkeypathandidentityfile ?? "") }).count ?? 0 > 0 else { return false }
        guard keyFileStrings?.filter({ $0.contains((sshkeypathandidentityfile ?? "") + ".pub") }).count ?? 0 > 0 else {
            throw SshError.sshkeys
        }
        rsaStringPath = keyFileStrings?.filter { $0.contains((sshkeypathandidentityfile ?? "") + ".pub") }[0]
        guard rsaStringPath?.count ?? 0 > 0 else { return false }
        throw SshError.sshkeys
    }

    public func validatepublickeypresent() -> Bool {
        guard keyFileStrings != nil else { return false }
        guard keyFileStrings?.filter({ $0.contains(sshkeypathandidentityfile ?? "") }).count ?? 0 > 0 else { return false }
        guard keyFileStrings?.filter({ $0.contains((sshkeypathandidentityfile ?? "") + ".pub") }).count ?? 0 > 0 else {
            return true
        }
        rsaStringPath = keyFileStrings?.filter { $0.contains((sshkeypathandidentityfile ?? "") + ".pub") }[0]
        guard rsaStringPath?.count ?? 0 > 0 else { return false }
        return true
    }

    public init( sharedsshport: String?,
                sharedsshkeypathandidentityfile: String?)
    {
        self.sharedsshport = sharedsshport
        self.sharedsshkeypathandidentityfile = sharedsshkeypathandidentityfile
    }
}

extension FileManager {
    func keypathlocationExists(at path: String, kind: LocationKind) -> Bool {
        var isFolder: ObjCBool = false

        guard fileExists(atPath: path, isDirectory: &isFolder) else {
            return false
        }

        switch kind {
        case .file: return !isFolder.boolValue
        case .folder: return isFolder.boolValue
        }
    }
}

/// Enum describing various kinds of locations that can be found on a file system.
public enum LocationKind {
    /// A file can be found at the location.
    case file
    /// A folder can be found at the location.
    case folder
}

public enum SshError: LocalizedError {
    case notvalidpath
    case sshkeys
    case noslash

    public var errorDescription: String? {
        switch self {
        case .notvalidpath:
            "SSH keypath is not valid"
        case .sshkeys:
            "SSH RSA keys exist, cannot create"
        case .noslash:
            "SSH keypath must be like ~/.ssh_keypath/identityfile"
        }
    }
}
