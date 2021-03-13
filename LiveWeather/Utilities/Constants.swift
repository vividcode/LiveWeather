//
//  Error.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 26/04/2020.
//  Copyright © 2020 Nirav Bhatt. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: String, Error {
    case invalidURL = "Invalid URL."
	case invalidRequest = "Invalid request."
	case conversionFailed = "ERROR: conversion from URL response failed."
}

enum  CustomError: String, Error {
    case preloadingError = "No pre-configured locations found."
}

struct UIOptions {
    static var locationsToShow: Int {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad:
			return 8
		case .phone:
			return 4
		default:
			return 0
		}
    }

	static var containerHeight: CGFloat {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad:
			return 420.0
		case .phone:
			return 300.0
		default:
			return 260.0
		}
	}

	static var hStackPadding: CGFloat {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad:
			return 40.0
		case .phone:
			return 16.0
		default:
			return 16.0
		}
	}

	static var vStackPadding: CGFloat {
		return 8.0
	}

	static var locationLabelHeight: CGFloat {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad:
			return 32.0
		case .phone:
			return 24.0
		default:
			return 24.0
		}
	}

	static var normalLabelHeight: CGFloat {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad:
			return 27.0
		case .phone:
			return 19.0
		default:
			return 19.0
		}
	}

	static var segmentFontHeight: CGFloat {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad:
			return 23.0
		case .phone:
			return 13.0
		default:
			return 13.0
		}
	}

	static var messageFontHeight: CGFloat {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad:
			return 24.0
		case .phone:
			return 17.0
		default:
			return 17.0
		}
	}
}

struct APIFetchOptions {
    static var apiFetchInterval: TimeInterval {
		#if DEBUG
		return 10.0
		#else
		return 60.0
		#endif
    }

    static var apiTimeout: TimeInterval
    {
		#if DEBUG
		return 30.0
		#else
		return 120.0
		#endif
    }
}

enum Environment: String {
	case dev, staging, prod, test
	static func getCurrentEnv() -> Environment {
		let envString = ProcessInfo.processInfo.environment["env"] ?? ""
		return Environment(rawValue: envString) ?? .dev
	}
}

struct EndPoint {
	private static let baseURLStringDict: [Environment: String] =
		[.dev: Gibberish.baseURLDev,
		 .staging: "<enter staging URL here>", .
			prod: "<enter prod URL here>",
		 .test: Gibberish.baseURLProd]

	static var baseURL: String {
		let currentEnv = Environment.getCurrentEnv()
		return EndPoint.baseURLStringDict[currentEnv]!
	}

	static var supportURL: String = Gibberish.supportURL

	enum Entity: String {
		case weather = "location/"
	}

	var entity: Entity
	var url: String {
		return EndPoint.baseURL + self.entity.rawValue
	}
}

// These constants can later be localized
enum DisplayConstants: String {
    case unavailable = "Unavailable"
    case fetching = "Fetching"
    case temperature = "Temperature"
	case weatherState = "Overall"
	case humidity = "Humidity"
	case windSpeed = "Wind Speed"
    case updatedAt = "Updated At"
	case tempUnit = " °C"
	case humidityUnit = " %"
	case windSpeedUnit = " mph"
	case noInternet = "Could not get weather data - please check your internet connection."
	case configurationError = "No locations configured - please contact developer support."
}
