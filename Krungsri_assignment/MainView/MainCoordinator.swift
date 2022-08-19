//
//  MainCoordinator.swift
//  Krungsri_assignment
//
//  Created by PMJs on 19/8/2565 BE.
//

import UIKit
import Foundation

class MainCoordinatorInput: CoordinatorInput {
    
    init() {
    
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
        if let input = input {
            let viewController = MainViewController.initFromStoryboard(name: Constant.StoryboardName.main, bundle: Bundle.main)
            
            navigationController.pushViewController(viewController, animated: false)
        }
    }
}
