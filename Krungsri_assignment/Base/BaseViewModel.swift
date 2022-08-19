//
//  BaseViewModel.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import RxSwift

public protocol BaseViewModel {}

extension BaseViewModel {
    var disposeBag: DisposeBag {
        return DisposeBag()
    }
}
