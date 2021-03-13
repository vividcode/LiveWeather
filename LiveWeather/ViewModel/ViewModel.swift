//
//  ViewModel.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 10/31/20.
//

import Foundation

typealias DataAvailableBlock = (_ withAnimation: Bool) -> Void

/*
 ViewModel: Implemented by ViewModels
 Responsible for initializing View model
 */
protocol ViewModel {
    var services: [Service] { get set }
    var networkService: NetworkService? { get }
    var fileService: FileService? { get }
    var databaseService: DatabaseService? { get }
    var updateUICallback: DataAvailableBlock { get set }
    var errorCallback: ErrorBlock { get set }
}

extension ViewModel {
    var networkService: NetworkService? {
		let networkServices: [NetworkService] = self.services.filterElementsOfType(forType: NetworkService.self)
		return networkServices.first
    }

    var fileService: FileService? {
		let fileServices: [FileService] = self.services.filterElementsOfType(forType: FileService.self)
		return fileServices.first
    }

    var databaseService: DatabaseService? {
		let databaseServices: [DatabaseService] = self.services.filterElementsOfType(forType: DatabaseService.self)
		return databaseServices.first
    }
}
