//
//  Service.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/3/20.
//

import Foundation

protocol Service {
    func getServiceInfo() -> String
}

extension Service {
    func getServiceInfo() -> String {
        return "Service Class:" + (NSStringFromClass(Self.self as! AnyClass).components(separatedBy: ".").last ?? "")
    }
}
