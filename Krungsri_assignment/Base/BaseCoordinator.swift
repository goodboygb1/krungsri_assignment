//
//  BaseCoordinator.swift
//  Krungsri_assignment
//
//  Created by PMJs on 19/8/2565 BE.
//

import Foundation
import UIKit
import RxSwift

public protocol CoordinatorInput {}
public protocol CoordinatorOutput {}

public protocol BaseCoordinator {
    var navigationController: UINavigationController { get set }
    var window: UIWindow { get }
    func start(input: CoordinatorInput?)
    init(navigationController: UINavigationController, window: UIWindow)
}

extension BaseCoordinator {
    var disposeBag: DisposeBag {
        return DisposeBag()
    }
}
