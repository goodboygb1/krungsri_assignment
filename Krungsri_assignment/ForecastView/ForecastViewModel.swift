//
//  ForecastViewModel.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class ForecastViewModel: BaseViewModel {
    
    let backgroundColour: BehaviorRelay<UIColor> = BehaviorRelay<UIColor>(value: .pomegranate)
    let weatherForcasts: BehaviorRelay<[Weather]> = BehaviorRelay<[Weather]>(value: [])
    
    //input
    let input: BehaviorRelay<(cityName: String,units: Units)> = BehaviorRelay<(cityName: String,units: Units)>(value: ("",.metric))
    let weatherRepository: WeatherRepository
    let jsonDecoder: JsonDecoderProtocol
    
    //action
    let reloadTableViewAction = PublishSubject<Void>()
    
    init(input: ForecastCoordinatorInput) {
        self.backgroundColour.accept(input.backgroundColour)
        self.weatherRepository = input.weatherRepository
        self.jsonDecoder = input.jsonDecoder
        self.bindObservable()
        self.input.accept((input.cityName, input.units))
    }
    
    func bindObservable() {
        input
            .skip(1)
            .flatMap{ [weak self] (cityName, units) -> Observable<JSON> in
                guard let self = self else { return Observable.empty()}
                return self.weatherRepository.getWeatherFiveDayForcast(with: cityName, units: units)
            }
            .flatMap { [weak self] result -> Observable<[Weather]> in
                guard let self = self else { return Observable.empty()}
                return self.jsonDecoder.decodeWeathersFiveDayForcase(from: result)
            }.bind(to: weatherForcasts)
    }
}
