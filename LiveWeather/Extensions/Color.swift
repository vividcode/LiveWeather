//
//  Color.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/3/20.
//

import Foundation
import UIKit

extension UIColor {
	static var appBackground: UIColor {
		return UIColor.init(named: "appBackground")!
	}

	static var errorMessage: UIColor {
		return UIColor.init(named: "errorMessage")!
	}

	static var segmentBackground: UIColor {
		return UIColor.init(named: "segmentBackground")!
	}

	static var segmentTint: UIColor {
		return UIColor.purple
	}

	static var panelBackground: UIColor {
		return UIColor.init(named: "panelBackground")!
	}
}
