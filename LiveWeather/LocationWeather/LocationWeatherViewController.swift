//
//  ViewController.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 10/30/20.
//

import UIKit

class LocationWeatherViewController: UIViewController {
    var didSetupConstraints: Bool = false
    static let tintColors: [UIColor] = [.red, .blue, .purple, .green]
    var locationWeatherView: LocationWeatherView?
    var viewModel: LocationWeatherViewModel!
    var isViewModelInitialized: Bool = false

    var locationWoeIds: [String] {
		let woeIds = self.viewModel.locations.map({ (location) -> String in
			return location.woeIdString()
		})

		return woeIds
    }

    var locationTitles: [String] {
		let titles = self.viewModel.locations.map({ (location) -> String in
			return location.title
		})

		return titles
    }

    // MARK: -
    // MARK: UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.isViewModelInitialized {
                self.createUI()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isViewModelInitialized {
            self.viewModel.startTimer(bFireOnce: false)
        }
    }

	// MARK: -
	// MARK: Create Layout
    func createUI() {
        self.view.backgroundColor = .appBackground
        self.locationWeatherView = LocationWeatherView(delegate: self, segmentTitles: self.locationTitles)
        self.view.addSubview(self.locationWeatherView!)
        self.locationWeatherView!.appearWithSpring()
        self.view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
		if self.didSetupConstraints {
            return
        }

        self.locationWeatherView?.createConstraints()

        self.didSetupConstraints = true
        super.updateViewConstraints()
    }

    // MARK: -
    // MARK: UI Update
	func updateUI(withAnimation: Bool) {
		self.locationWeatherView?.updateUI(temperature: self.viewModel.getTemperatureAsString(),
										   timeStamp: self.viewModel.getUpdatedTimeAsString(),
										   humidity: self.viewModel.getHumidityAsString(),
										   windSpeed: self.viewModel.getWindSpeedAsString(),
										   weatherState: self.viewModel.getWeatherStateNameAsString(),
										   withAnimation: withAnimation)
    }
}

// MARK: -
// MARK: View Model Initialization
extension LocationWeatherViewController: ViewModelOwner {
    func initializeViewModel() {
        do {
            self.viewModel = LocationWeatherViewModel(updateUICallback: { withAnimation in
				self.updateUI(withAnimation: withAnimation)
            }, errCallback: { _ in
				self.showMessageLabel(msg: DisplayConstants.noInternet.rawValue)
            },
            services: [RealNetworkService(), RealFileService()])
            try self.viewModel.preloadLocations(locationsFileName: "Locations")
            self.isViewModelInitialized = true
        } catch _ as CustomError {
            self.isViewModelInitialized = false
            DispatchQueue.main.async {
				self.showAlert(msg: DisplayConstants.configurationError.rawValue ,
							   okTitle: "Cancel", cancelTitle: "Contact Support", okPressed: nil,
                cancelPressed: {
					UIApplication.shared.openWeblink(urlStr: EndPoint.supportURL)
                })
            }

            return
        } catch let err as NSError {
            self.isViewModelInitialized = false
            print("\(err.description)")
            return
        }
    }
}

// MARK: -
// MARK: Segment control callback
extension LocationWeatherViewController: LocationWeatherViewDelegate {
    func segmentSelected(idx: Int) {
        let locationWoeId = self.locationWoeIds[idx]
        self.viewModel.changeLocation(locationWoeId: locationWoeId)
    }
}
