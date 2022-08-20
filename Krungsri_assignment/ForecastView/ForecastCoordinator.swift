//
//  ForcastCoordinator.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import UIKit

class ForecastCoordinatorInput: CoordinatorInput {
    let cityName: String
    let backgroundColour: UIColor
    let weatherRepository: WeatherRepository
    let units: Units
    let jsonDecoder: JsonDecoderProtocol
    
    init(cityName: String, backgroundColour: UIColor, weatherRepository: WeatherRepository, units: Units, jsonDecoder: JsonDecoderProtocol) {
        self.cityName = cityName
        self.backgroundColour = backgroundColour
        self.weatherRepository = weatherRepository
        self.units = units
        self.jsonDecoder = jsonDecoder
    }
}

class ForecastCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    
    var window: UIWindow
    
    required init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start(input: CoordinatorInput?) {
        if let input = input as? ForecastCoordinatorInput {
            let viewController = ForecastViewController.initFromStoryboard(name: Constant.StoryboardName.forecaste, bundle: Bundle.main)
            
            let viewModel = ForecastViewModel(input: input)
            
            viewController.viewModel = viewModel
            
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
}
