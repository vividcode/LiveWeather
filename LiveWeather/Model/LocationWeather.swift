//
//  LocationWeather.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 10/31/20.
//

import Foundation

struct LocationWeather: Codable {
    var location: Location
    var weather: Weather

    private enum LocationWeatherKeys: String, CodingKey {
        case woeId = "woeid"
        case title = "title"
        case locationType = "location_type"
        case consolidatedWeatherRecords = "consolidated_weather"
        case weather = "weather"
        case location = "location"
    }

	private var isFetching: Bool
	var temperatureAsString: String {
		if self.isFetching {
			return "--" + DisplayConstants.tempUnit.rawValue
		}

		let temperature = self.weather.temperature
		let temperatureValue = String(format: "%.1f", temperature) + DisplayConstants.tempUnit.rawValue
		return temperatureValue
	}

	var humidityAsString: String {
		if self.isFetching {
			return "--" + DisplayConstants.humidityUnit.rawValue
		}

		let humidity = self.weather.humidity
		let humidityValue = String(format: "%.0f", humidity) + DisplayConstants.humidityUnit.rawValue
		return humidityValue
	}

	var windSpeedAsString: String {
		if self.isFetching {
			return "--" + DisplayConstants.windSpeedUnit.rawValue
		}

		let windSpeed = self.weather.windSpeed
		let windSpeedValue = String(format: "%.1f", windSpeed) + DisplayConstants.windSpeedUnit.rawValue
		return windSpeedValue
	}

	var timeStampString: String {
		if self.isFetching {
			return Date().getFriendlyTime()
		}

		return self.weather.timeStamp.getFriendlyTime()
	}

	var weatherStateNameString: String {
		if self.isFetching {
			return "--"
		}

		return self.weather.weatherStateName
	}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationWeatherKeys.self)
        let woeId = try container.decode(Int.self, forKey: .woeId)
        let title = try container.decode(String.self, forKey: .title)
        let locationType = try container.decode(String.self, forKey: .locationType)

        self.location = Location(woeId: woeId, title: title, locationType: locationType)
        let weatherRecords = try container.decode([Weather].self, forKey: .consolidatedWeatherRecords)

        self.weather = {
			if weatherRecords.count == 0 {
                return Weather.invalidInstance
            }

            if weatherRecords.count == 1 {
                return weatherRecords.first!
            }

            let sortedWeatherRecords = weatherRecords.sorted { (w1, w2) -> Bool in
                return w1.timeStamp > w2.timeStamp
            }

            let latestWeather = sortedWeatherRecords.first!

            return latestWeather
        }()

		self.isFetching = false
    }

	mutating func changeIsFetching() {
		self.isFetching = true
	}

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LocationWeatherKeys.self)
        try container.encode(self.location, forKey: .location)
        try container.encode([self.weather], forKey: .consolidatedWeatherRecords)
    }
}
