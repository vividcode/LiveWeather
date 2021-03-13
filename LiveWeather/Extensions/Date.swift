//
//  Date.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/1/20.
//

import Foundation

extension Date {
    func getFriendlyTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = NSTimeZone.local
        let str = dateFormatter.string(from: self)
        return str
    }
}
