//
//  File.swift
//  RsyncArguments
//
//  Created by Thomas Evensen on 05/08/2024.
//

import Foundation

final class LoadTestData {
    var testconfigurations = [TestSynchronizeConfiguration]()
    
    func getdata() async {
        do {
            let testdata = DecodeTestdataFromGitHub()
            if let testdata = try await testdata.gettestdatabyURL() {
                testconfigurations.removeAll()
                for i in 0 ..< testdata.count {
                    var configuration = TestSynchronizeConfiguration(testdata[i])
                    configuration.profile = "test"
                    testconfigurations.append(configuration)
                }
                print("LoadTestData: loading data COMPLETED)")
            }
        } catch {
            print("LoadTestData: loading data FAILED)")
        }
    }
}
