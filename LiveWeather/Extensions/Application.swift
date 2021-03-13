//
//  Application.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/4/20.
//

import Foundation
import UIKit

extension UIApplication {
    func openWeblink(urlStr: String) {
        if let url = URL(string: urlStr) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
