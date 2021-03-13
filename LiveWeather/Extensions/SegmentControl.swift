//
//  SegmentControl.swift
//  LiveWeather
//
//  Created by Admin on 3/13/21.
//

import Foundation
import UIKit

extension UISegmentedControl {
	var selectedSegmentColor: UIColor {
		get {
			if #available(iOS 13, *) {
				return self.selectedSegmentTintColor ?? UIColor.systemBlue
			} else {
				return self.tintColor
			}
		}

		set {
			if #available(iOS 13, *) {
				self.selectedSegmentTintColor = newValue
			} else {
				self.tintColor = newValue
			}
		}
	}
}
