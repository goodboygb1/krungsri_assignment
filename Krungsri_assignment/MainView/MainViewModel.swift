//
//  MainViewModel.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import SwiftyJSON
import CoreLocation

class MainViewModel: BaseViewModel {
    
    let weatherRepository: WeatherRepository
    let jsonDecoder: JsonDecoderProtocol
    
    // input
    let input: BehaviorRelay<(cityName: String,units: Units)> = BehaviorRelay<(cityName: String,units: Units)>(value: ("",.metric))
    
    // output
    var temperature: Driver<Double>?
    var huminity: Driver<Int>?
    var backgroundColour: Driver<UIColor>?
    var weatherImageUrl: Observable<String>?
    let changeTempAction = PublishSubject<Bool>()
    
    var units: Units = .metric
    let weather = BehaviorRelay<Weather?>(value: nil)
    
    
    init(input: MainCoordinatorInput) {
        self.weatherRepository = input.weatherRepository
        self.jsonDecoder = input.jsonDecoderHelper
        bindObserable()
    }
    
    func bindObserable() {
        let weather = input
            .skip(1)
            .flatMap{ [weak self] (cityName, units) -> Observable<JSON> in
                guard let self = self else { return Observable.empty()}
                return self.weatherRepository.getWeather(with: cityName, units: units)
            }
            .flatMap { [weak self] result -> Observable<Weather?> in
                guard let self = self else { return Observable.empty()}
                return self.jsonDecoder.decodeWeather(from: result)
            }
            .do(onNext: { [weak self] weather in
                self?.weather.accept(weather)
            })
        
        temperature = weather
            .map({$0?.temperature ?? 0.0})
            .asDriver(onErrorJustReturn: 0.0)
        
        huminity = weather
            .map({$0?.humidity ?? 0})
            .asDriver(onErrorJustReturn: 0)
        
        weatherImageUrl = weather
            .map({$0?.weatherImageUrl ?? ""})
        
        backgroundColour = weather
            .map { weather -> UIColor in
                guard let icon = weather?.icon else { return .peterRive }
                
                if icon.contains("n") {
                    // night colour
                    return .midnightBlue
                } else if icon.contains("d") {
                    if icon.contains("01") || icon.contains("02") {
                        // day colour
                        return .pomegranate
                    }
                }
                // default colour
                return .peterRive
            }
            .asDriver(onErrorJustReturn: .peterRive)
    }
}
