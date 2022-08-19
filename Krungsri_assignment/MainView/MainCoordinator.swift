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
            
            navigationController.pushViewController(viewController, animated: false)
        }
    }
}
