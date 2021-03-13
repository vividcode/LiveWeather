//
//  DatabaseService.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/3/20.
//

import Foundation

protocol DatabaseService: Service {
    func getDataFromDB() -> [Codable]
}
