//
//  UIViewControllerExtension.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    public static func initFromStoryboard(name: String, bundle: Bundle) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Can't initFromStorybaord name: \(name) from viewController: \(storyboardIdentifier)")
        }
        return viewController
    }
}
