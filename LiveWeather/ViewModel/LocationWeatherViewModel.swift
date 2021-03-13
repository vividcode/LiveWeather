//
//  LocationWeatherViewModel.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 10/31/20.
//

import Foundation
import UIKit

typealias ErrorBlock = (String) -> Void

class LocationWeatherViewModel: ViewModel {
    var updateUICallback: DataAvailableBlock
    var errorCallback: ErrorBlock
    var services: [Service]
	private var apiEndPoint: EndPoint = EndPoint(entity: .weather)
    private var locationWoeId: String?

    var locationWeather: LocationWeather?
    private var apiTimer: Timer?
    var locations: [Location] = []
    init(updateUICallback:@escaping DataAvailableBlock, errCallback:@escaping ErrorBlock, services: [Service]) {
        self.updateUICallback = updateUICallback
        self.errorCallback = errCallback
        self.services = services
    }

    /* Preload locations whose weather needs to be shown. Currently,
	this uses pre-configured locations from a JSON file within the bundle.
	File service is used to populate them. They could optionally be loaded
	from database service as well. Without any locations, view controller
	will display error alert to the user.*/
    func preloadLocations(locationsFileName: String) throws {
        self.locations =
        {
            let allLocations: [Location] = (self.fileService?.loadModelArrayFromJSON(filename: locationsFileName)) ?? []
            let countToKeep = UIOptions.locationsToShow
            let locations = allLocations.dropLast((allLocations.count > countToKeep) ?
													allLocations.count - countToKeep : 0)
            return Array(locations)
        }()

        if self.locations.isEmpty {
            throw CustomError.preloadingError
        }

        self.locationWoeId = self.locations.first!.woeIdString()
    }

    /** Start to fetch data from API in timed manner. Currently, the interval is
	kept as an implementation detail constant but can also be supplied as a
	dependency to viewmodel or argument to startTimer.*/
    func startTimer(bFireOnce: Bool) {
        let timeInterval = APIFetchOptions.apiFetchInterval
        self.apiTimer = Timer.init(fire: Date(), interval: timeInterval, repeats: !bFireOnce) { (_) in
            self.getLocationWeatherFromAPI()
        }

        RunLoop.current.add(self.apiTimer!, forMode: RunLoop.Mode.default)
    }
    /**Stops the timer and hence, fetching of API data. Used in user switching the location.*/
    func stopTimer() {
        if self.apiTimer?.isValid ?? false {
            self.apiTimer?.invalidate()
        }
    }

    func changeLocation(locationWoeId: String) {
        self.locationWoeId = locationWoeId
		self.locationWeather?.changeIsFetching()
		self.updateUICallback(false)
        self.stopTimer()
        self.startTimer(bFireOnce: false)
    }

    // MARK: Helper to get weather params for UI
    func getTemperatureAsString() -> String {
        return self.locationWeather?.temperatureAsString ?? DisplayConstants.unavailable.rawValue
    }

	func getHumidityAsString() -> String {
		return self.locationWeather?.humidityAsString ?? DisplayConstants.unavailable.rawValue
	}

	func getWindSpeedAsString() -> String {
		return self.locationWeather?.windSpeedAsString ?? DisplayConstants.unavailable.rawValue
	}

	func getWeatherStateNameAsString() -> String {
		return self.locationWeather?.weatherStateNameString ?? DisplayConstants.unavailable.rawValue
	}

    /**Helper to get timestamp for UI*/
    func getUpdatedTimeAsString() -> String {
		return self.locationWeather?.timeStampString ?? Date().getFriendlyTime()
    }

    /**Get weather data for selected location from API. This function uses supplied NetworkService dependency class.*/
    private func getLocationWeatherFromAPI() {
        self.networkService?.getFromAPI(endPoint: self.apiEndPoint,
										entityId: self.locationWoeId!) { (data) in
            do {
                let decoder = JSONDecoder.init()

                self.locationWeather = try decoder.decode(LocationWeather.self, from: data)
                DispatchQueue.main.async {
					self.updateUICallback(true)
                }
            } catch let err as NSError {
                DispatchQueue.main.async {
                    print("Error: \(err)")
                    self.errorCallback("Error getting weather from API.")
                }
            }
        }
        noDataBlock: {
            DispatchQueue.main.async {
				print("No data received")
                self.errorCallback("No weather data available from API.")
            }
        }
        errorBlock: { (err) in
            DispatchQueue.main.async {
                print("Error: \(err)")
                self.errorCallback("Error getting weather from API.")
            }
        }
    }
}
