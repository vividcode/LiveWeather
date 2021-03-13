//
//  ViewModelOwner.swift
//  LiveWeather
//
//  Created by Admin on 11/4/20.
//

import Foundation

/*
 ViewModelOwner: Usually implemented by View Controller
 Responsible for initializing View model
 */
protocol ViewModelOwner {
    func initializeViewModel()
}
