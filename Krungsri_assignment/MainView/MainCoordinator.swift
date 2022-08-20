//
//  MainCoordinator.swift
//  Krungsri_assignment
//
//  Created by PMJs on 19/8/2565 BE.
//

import UIKit
import Foundation

class MainCoordinatorInput: CoordinatorInput {
    let jsonDecoderHelper: JsonDecoderProtocol
    let weatherRepository: WeatherRepository
    
    init(jsonDecoderHelper: JsonDecoderProtocol, weatherRepository: WeatherRepository) {
        self.jsonDecoderHelper = jsonDecoderHelper
        self.weatherRepository = weatherRepository
    }
}

class MainCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    var window: UIWindow
    
    required init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start(input: CoordinatorInput? = nil) {
        if let input = input as? MainCoordinatorInput {
            let viewController = MainViewController.initFromStoryboard(name: Constant.StoryboardName.main, bundle: Bundle.main)
            
            let viewModel = MainViewModel(input: input)
            
            viewController.viewModel = viewModel
            
            viewController.showForecastAction.subscribe(onNext: { [weak self] _ in
                self?.showFiveDayForcast(
                    with: viewModel.input.value.cityName,
                    backgroundColour: viewController.backgroundView.backgroundColor ?? .peterRive,
                    weatherRepository: input.weatherRepository,
                    units: viewModel.units,
                    jsonDecoderHelper: input.jsonDecoderHelper
                )
            })
            
            navigationController.pushViewController(viewController, animated: false)
        }
    }
    
    func showFiveDayForcast(with cityName: String, backgroundColour: UIColor, weatherRepository: WeatherRepository, units: Units, jsonDecoderHelper: JsonDecoderProtocol) {
        let input = ForecastCoordinatorInput(
            cityName: cityName,
            backgroundColour: backgroundColour,
            weatherRepository: weatherRepository,
            units: units,
            jsonDecoder: jsonDecoderHelper
        )
        let coordinator = ForecastCoordinator(navigationController: navigationController, window: window)
        
        coordinator.start(input: input)
    }
}
