//
//  File.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 05/08/2024.
//

import Foundation

struct GetTestdata {
    let urlSession = URLSession.shared
    let jsonDecoder = JSONDecoder()
    
    private var urlJSON: String = "https://raw.githubusercontent.com/rsyncOSX/RsyncArguments/master/Testdata/configurations.json"

    func getversionsofrsyncuibyurl() async throws -> [DecodeTestdata]? {
        if let url = URL(string: urlJSON) {
            let (data, _) = try await urlSession.gettestdata(for: url)
            return try jsonDecoder.decode([DecodeTestdata].self, from: data)
        } else {
            return nil
        }
    }
}

public extension URLSession {
    func gettestdata(for url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url)
    }
}
