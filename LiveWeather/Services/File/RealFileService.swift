//
//  FileService.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/1/20.
//

import Foundation

class RealFileService: FileService {
    func loadModelArrayFromJSON<T: Codable>(filename: String) -> [T] {
		guard let data = self.dataFromJSONFile(filename: filename)
        else {
            return []
        }

        let decoder = JSONDecoder()

        do {
            let modelArray = try decoder.decode([T].self, from: data)
            return modelArray
        } catch let err as NSError {
            print("Could not load Model from JSON: \(err)")
            return []
        }
    }

    func loadModelFromJSON<T: Codable>(filename: String) -> T? {
        guard let data = self.dataFromJSONFile(filename: filename)
		else {
            return nil
        }

        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch let err as NSError {
            print("Could not load Model from JSON: \(err)")
            return nil
        }
    }

    func dataFromJSONFile(filename: String) -> Data? {
        guard let preloadedJSON = Bundle.currentBundle(forClass: Self.self).path(forResource: filename, ofType: "json")
        else {
            return nil
        }

        guard let data = FileManager.default.contents(atPath: preloadedJSON)
        else {
            return nil
        }

        return data
    }
}
