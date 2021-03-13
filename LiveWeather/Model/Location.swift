//
//  Location.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/1/20.
//

import Foundation

struct Location: Codable {
    var woeId: Int
    var title: String
    var locationType: String

    private enum LocationKeys: String, CodingKey {
        case woeId = "woeid"
        case title = "title"
        case locationType = "location_type"
    }

    init(woeId: Int, title: String, locationType: String) {
        self.woeId = woeId
        self.title = title
        self.locationType = locationType
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationKeys.self)
        self.woeId = try container.decode(Int.self, forKey: .woeId)
        self.title = try container.decode(String.self, forKey: .title)
        self.locationType = try container.decode(String.self, forKey: .locationType)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LocationKeys.self)
        try container.encode(self.woeId, forKey: .woeId)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.locationType, forKey: .locationType)
    }

    func woeIdString() -> String {
        return String(self.woeId)
    }
}
