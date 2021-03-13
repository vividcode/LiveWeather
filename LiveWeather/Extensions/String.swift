//
//  String.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 10/31/20.
//

import Foundation

extension String {
    func isoDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
		let date = dateFormatter.date(from: self)
        return date
    }
}
