//
//  LiveWeatherTests.swift
//  LiveWeatherTests
//
//  Created by Nirav Bhatt on 11/2/20.
//

import XCTest

class LiveWeatherServiceTests: XCTestCase {
    var services: [Service]?

    override func setUpWithError() throws {
        self.services  = [RealFileService(), DummyNetworkService()]
    }

    override func tearDownWithError() throws {
        self.services = nil
    }

    func testServices() {
        for s in self.services ?? [] {
            let info = s.getServiceInfo()
            XCTAssert(info.isEmpty == false)
        }
    }
}
