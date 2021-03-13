//
//  Bundle.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/3/20.
//

import Foundation

extension Bundle {
    class func currentBundle(forClass: AnyClass) -> Bundle {
        return Bundle.init(for: forClass.self)
    }

    class func getProductDisplayName() -> String {
        guard let productName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        else {
            return "LiveWeather"
        }

        return productName
    }
}
