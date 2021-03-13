//
//  Weather.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/1/20.
//

import Foundation

struct Weather: Codable {
    var weatherObservationId: Int
    var weatherStateName: String
    var temperature: Double
    var humidity: Double
    var windSpeed: Double
    var timeStamp: Date

    enum WeatherKeys: String, CodingKey {
        case weatherObservationId = "id"
        case weatherStateName = "weather_state_name"
        case temperature = "the_temp"
        case humidity = "humidity"
        case windSpeed = "wind_speed"
        case observationTimestampStr = "created"
    }

    static let invalidInstance = Weather(weatherObservationId: -12345, weatherStateName: "",
										 weatherStateAbbr: "", temperature: -10000.0, humidity: -100.0,
										 windSpeed: -100.0, timeStamp: Date(timeIntervalSinceReferenceDate: 0))

    init (weatherObservationId: Int, weatherStateName: String, weatherStateAbbr: String,
		  temperature: Double, humidity: Double, windSpeed: Double, timeStamp: Date) {
        self.weatherObservationId = weatherObservationId
        self.weatherStateName = weatherStateName
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.timeStamp = timeStamp
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherKeys.self)
        self.weatherObservationId = try container.decode(Int.self, forKey: .weatherObservationId)
        self.weatherStateName = try container.decode(String.self, forKey: .weatherStateName)
        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.humidity = try container.decode(Double.self, forKey: .humidity)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)

        let observationTimestampStr = try container.decode(String.self, forKey: .observationTimestampStr)

        guard let d = observationTimestampStr.isoDate()
        else {
            throw NetworkError.conversionFailed
        }

        self.timeStamp = d
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: WeatherKeys.self)
        try container.encode(self.weatherObservationId, forKey: .weatherObservationId)
        try container.encode(self.weatherStateName, forKey: .weatherStateName)
        try container.encode(self.temperature, forKey: .temperature)
        try container.encode(self.humidity, forKey: .humidity)
        try container.encode(self.windSpeed, forKey: .windSpeed)
    }
}
