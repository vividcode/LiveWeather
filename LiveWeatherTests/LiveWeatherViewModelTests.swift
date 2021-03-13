//
//  LiveWeatherTests.swift
//  LiveWeatherTests
//
//  Created by Nirav Bhatt on 11/2/20.
//

import XCTest

enum TestResult: Int {
	case success, fail, inProgress
}

class LiveWeatherViewModelTests: XCTestCase {
    var viewModel: LocationWeatherViewModel?
	var testResult: TestResult = .inProgress

    override func setUpWithError() throws {
		self.viewModel = LocationWeatherViewModel(updateUICallback: { _ in
            let locationWeather = self.viewModel?.locationWeather
            XCTAssert(locationWeather?.location.title == "London")
			self.testResult = .success
        }, errCallback: { (_) in
			self.testResult = .fail
        }, services: [DummyNetworkService(), RealFileService()])
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    func testLocationWeatherViewModelWithSuccess() throws {
		try self.viewModel?.preloadLocations(locationsFileName: "fakeLocations")
        viewModel?.startTimer(bFireOnce: true)

        let exp = expectation(description: "testLocationWeatherViewModelWithSuccess")

        let result = XCTWaiter.wait(for: [exp], timeout: 2)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(self.testResult == .success)
        } else {
             XCTFail("Delay interrupted")
        }
    }

	func testConfigurationError() throws {
        let exp = expectation(description: "testLocationWeatherViewModelNoPreloading")
        let result = XCTWaiter.wait(for: [exp], timeout: 0.1)

        if result == XCTWaiter.Result.timedOut {
            do {
				try self.viewModel?.preloadLocations(locationsFileName: "NoLocations")
            } catch {
                exp.fulfill()
            }
        } else {
             XCTFail("Delay interrupted")
        }
    }
}
