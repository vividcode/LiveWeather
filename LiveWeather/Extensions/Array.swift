//
//  Array.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/4/20.
//

import Foundation

extension Array {
    func filterElementsOfType<T>(forType: T.Type) -> [T] where T: Any {
        let filteredArray = self.compactMap { (s) -> T? in
           return s as? T
       }

        return filteredArray
    }
}
