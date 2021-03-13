//
//  LiveWeatherModelTests.swift
//  LiveWeatherTests
//
//  Created by Nirav Bhatt on 11/3/20.
//

import XCTest

class LiveWeatherModelTests: XCTestCase {
    func testLocationModel() {
        if let model: Location = RealFileService().loadModelFromJSON(filename: "LocationTestJSON") {
            XCTAssert(model.title == "New York")
            return
        }

        XCTFail("testLocationrModel failed")
    }

    func testWeatherModel() {
        if let model: Weather = RealFileService().loadModelFromJSON(filename: "WeatherTestJSON") {
            XCTAssert(model.weatherObservationId == 222222)
            XCTAssert(model.weatherStateName == "Light Rain")
            return
        }

        XCTFail("testWeatherModel failed")
    }

    func testLocationWeatherModel() {
        if let model: LocationWeather = RealFileService().loadModelFromJSON(filename: "LocationWeatherTestJSON") {
            XCTAssertNotNil(model.location)
            XCTAssertNotNil(model.weather)
            return
        }

        XCTFail("testLocationWeatherModel failed")
    }
}
