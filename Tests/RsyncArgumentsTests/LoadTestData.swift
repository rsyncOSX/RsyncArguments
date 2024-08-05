//
//  File.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 05/08/2024.
//

import Foundation

final class LoadTestData {
    func getdata() async {
        do {
            let getTestdatafromGitHub = GetTestdatafromGitHub()
            if let data = try await getTestdatafromGitHub.gettestdatabyURL() {
                print(data)
            }
        } catch {
            print("LoadTestData: loading data failed)")
        }
    }
}
