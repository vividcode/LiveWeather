//
//  FileService.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/4/20.
//

import Foundation

protocol FileService: Service {
    func loadModelArrayFromJSON<T: Codable>(filename: String) -> [T]
    func loadModelFromJSON<T: Codable>(filename: String) -> T?
    func dataFromJSONFile(filename: String) -> Data?
}
